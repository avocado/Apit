class Activity < ActiveRecord::Base
	has_many :subscriptions
	has_many :users, :through => :subscriptions
	validates_numericality_of :subscribers, :on => :save, :message => "is not a number"
	validates_numericality_of :friends, :on => :save, :message => "is not a number"
	
end
