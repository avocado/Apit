class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :roles_ids, :remember_me, :firstname, :lastname
	has_and_belongs_to_many :roles
	has_many :subscriptions
	has_many :activities, :through => :subscriptions	

	
	def role?(role)  
	  self.roles.find_by_name(role)
	end
	
	def naam
		self.firstname||=""
		self.lastname||=""
		self.firstname+" "+self.lastname
	end
	
end
