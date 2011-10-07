class Role < ActiveRecord::Base
	has_and_belongs_to_many :users
	def title
	  self.name
  end
end
