class ApplicationController < ActionController::Base
	helper :all # include all helpers, all the time
	before_filter :define_menu
	protect_from_forgery # See ActionController::RequestForgeryProtection for details
	
	rescue_from CanCan::AccessDenied do |exception|
	  redirect_to root_url, :alert => exception.message
	end

  def allow_admin
    redirect_to root_url
  end

	def define_menu
		@root_page = Page.find_by_permalink('root')
		@permalink = request.parameters[:permalink]
		
	@banners = UploadFolder.find_by_name('banners').upload_files if !UploadFolder.find_by_name('banners').nil?
	@banners||=[]
	@sponsoren = UploadFolder.find_by_name('sponsoren').upload_files if !UploadFolder.find_by_name('sponsoren').nil?
	@sponsoren||=[]
	@sponsoren.shuffle
	end


end
