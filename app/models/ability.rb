class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    	if user.role?(:administrator)
    		can :manage, :all
				can :assign, Role
    	elsif user.role?(:webmaster)
				can :manage, Page
				can :manage, Activity
				can :manage, UploadFile
				can :manage, UploadFolder
				can :assign, Role do role
					role.name==:webmaster
				end
				can :manage, User do |u|
					# can edit user if it is myself
					return true if u.id == user.id
					
					# can edit all (except other admins) if i am an administrator
					return true if user.role?(:administrator) && !user.role?(:administrator)
					
					# can edit all users (except administrator) when i am a webmaster
					return true if user.role?(:webmaster) && !user.role?(:administrator)

					false
				end
			else
				can :read, Page
				can :create, User
    	end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
