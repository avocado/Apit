class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
		namefilter = params[:filtername] || ""
    @users = User.where(['firstname LIKE ? OR lastname LIKE ? OR email LIKE ?', '%'+namefilter+'%','%'+namefilter+'%','%'+namefilter+'%']).page params[:page]
		authorize! :update, User
		
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
	begin
		@user=User.find(params[:id])
	rescue ActiveRecord::RecordNotFound
    @user=current_user
  end
		if @user.nil?
			redirect_to(new_user_path())
			return
		end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
		authorize! :create, User
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
		@doenedit=true
		if params[:id]=="ik"||params[:id].to_s==current_user.id.to_s
			@user=current_user
		else
			@user=User.find(params[:id])
    end
   	authorize! :update, @user
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
		authorize! :create, User
		
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
   	if params[:id]=="ik"||params[:id].to_s==current_user.id.to_s
			@user=current_user
			sign_in(current_user, :bypass => true)
		else
			@user=User.find(params[:id])
		end
		authorize! :update, @user
	  params[:user].delete(:password) if params[:user][:password].blank?
	  params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

		respond_to do |format|
      if @user.update_attributes(params[:user])
		    if current_user==@user
			    sign_in(current_user, :bypass => true)
				end
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user=User.find(params[:id])
		can? :destroy, @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
