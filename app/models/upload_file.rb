class UploadFile < ActiveRecord::Base
	belongs_to :upload_folder
	attr_accessible :upload_folder_id
end
