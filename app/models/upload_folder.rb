class UploadFolder < ActiveRecord::Base
	has_many :upload_files
end
