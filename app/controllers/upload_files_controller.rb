class UploadFilesController < ApplicationController
	load_and_authorize_resource  
	# GET /groups
  # GET /groups.xml
  def index
    @folders = UploadFolder.all(:include=>:upload_files)
		authorize! :update, UploadFolder

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @folders }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @upload_file = UploadFile.find(params[:id])
		authorize! :update, @upload_file
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upload_file }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @upload_file = UploadFile.new
		authorize! :create, UploadFile
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload_file }
		end
  end

  # GET /groups/1/edit
  def edit
    @upload_file = UploadFile.find(params[:id])
		authorize! :update, @upload_file
  end

  # POST /groups
  # POST /groups.xml
  def create
	
    @upload_file = UploadFile.new(params[:upload_file])
		authorize! :create, @upload_file
		
		if !params[:upload_file][:upload].nil?
			name =  params[:upload_file][:upload].original_filename
      directory = "public/bestand"
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, "wb") { |f| f.write(params[:upload_file][:upload].read) }
		end

    respond_to do |format|
      if @upload_file.save
        flash[:notice] = 'Group was successfully created.'
	      format.html { redirect_to(upload_files_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @upload_file = UploadFile.find(params[:id])
		authorize! :create, @upload_file

		if params[:upload]
			name = UploadFile.save(params[:upload])
			@upload_file.filename = name
		end
		
    respond_to do |format|
      if @upload_file.update_attributes(params[:upload_file])
	      format.html { redirect_to(upload_files_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @upload_file = UploadFile.find(params[:id])
		authorize! :destroy, @upload_file
    @upload_file.destroy

    respond_to do |format|
      format.html { redirect_to(upload_files_url) }
      format.xml  { head :ok }
    end
  end



end
