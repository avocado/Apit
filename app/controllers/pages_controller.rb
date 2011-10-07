class PagesController < ApplicationController
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages =  Page.find(:all)
		authorize! :create, Page

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

	def order
		authorize! :create, Page
		if params[:page]
			step = 0
			params[:page].each do |p|
				pagina = Page.find_by_id(p.to_i)
				pagina.positie=step
				pagina.save
				step+= 1
			end
		end
    respond_to do |format|
      format.js { render :text=> ""}
    end
	end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    if params[:permalink]
			if params[:permalink]=="root"
      	@page = Page.find_by_permalink("home")
				
				@page = Page.find_by_permalink(params[:permalink]) if @page.nil?
			else
				@page = Page.find_by_permalink(params[:permalink])
			end
      raise ActiveRecord::RecordNotFound "Page not found." if @page.nil?
    else
      @page = Page.find(params[:id])
    end

		if @page.only_gedoopten && !current_user.gedoopt
	    respond_to do |format|
				format.html { render "verboden" }
	    end
		return
	  end
	
		if @page.inactief
	    respond_to do |format|
				format.html { render "verboden" }
	    end
		return
	  end
	
	
		if @page.only_leden && current_user.aescucard.nil?
	    respond_to do |format|
				format.html { render "verboden" }
	    end
		return
	  end
	
		authorize! :read, @page
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new
		authorize! :create, @page

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

	def newunderparent
		if(params[:parent])
			@page = Page.new(:parent_id=>params[:parent],:title=>"Nieuwe pagina",:permalink=>Time.now.to_i.to_s,:content=>"")
			authorize! :create, @page
			@page.positie=Page.sum(:positie)+1
			respond_to do |format|
				format.html { render :action => "edit" }
			end
		end
	end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
		authorize! :update, @page
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
		authorize! :create, @page

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to(@page) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
		authorize! :update, @page

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to(@page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
		authorize! :destroy, @page
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end
