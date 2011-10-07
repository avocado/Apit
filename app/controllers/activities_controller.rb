class ActivitiesController < ApplicationController
  
  # GET /activities
  # GET /activities.xml
  def index
    @activities = Activity.find(:all, :order => "`date` ASC", :conditions => ["`date` > ?",Time.now])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  def subscriptions
    @activities = Activity.find(:all, :order => "`date` ASC", :conditions => ["`date` > ?",Time.now], :include=>[:subscriptions,:users])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

	def add
		if current_user.nil?
			respond_to do |format|
      format.js { render :partial => 'nietingelogd',:locals => {:activiteit=>@activiteit, :vrij=>@vrij}}
    	end
			return
		end
    @activiteit = Activity.find(params[:id])
		@vrij=@activiteit.subscribers.to_i
		deelnemers=@activiteit.subscriptions.size
		vrienden = @activiteit.subscriptions.sum(:vrienden).to_i
		@vrij-=vrienden
		@vrij-=deelnemers

		if @vrij>0
			@sub = current_user.subscriptions.find_by_activity_id(@activiteit.id)
			if @sub.nil?
				@sub = Subscription.new(:user=>current_user,:activity=>@activiteit)
				@sub.vrienden=0
				@vrij-=1
				Notifier.deliver_ingeschreven_voor(@activiteit,current_user)  
				
			else
				if @sub.vrienden<@activiteit.friends
					@vrij-=1
					@sub.vrienden+=1 
				end
			end
			@sub.save!
		end
    respond_to do |format|
      format.js { render :partial => 'activiteitjs',:locals => {:activiteit=>@activiteit, :vrij=>@vrij}}
    end		
	end
	
	def substract
		if current_user.nil?
			respond_to do |format|
      format.js { render :partial => 'nietingelogd',:locals => {:activiteit=>@activiteit, :vrij=>@vrij}}
    	end
			return
		end
    @activiteit = Activity.find(params[:id])
		@vrij=@activiteit.subscribers.to_i
		deelnemers=@activiteit.subscriptions.size
		vrienden = @activiteit.subscriptions.sum(:vrienden).to_i

		@vrij-=vrienden
		@vrij-=deelnemers
		@sub = current_user.subscriptions.find_by_activity_id(@activiteit.id)
		if @sub.nil?
			#all good
		else
			if @sub.vrienden>0
				@sub.vrienden-=1
				@sub.save!
			else
				@sub.delete
			end
					@vrij+=1
		end

    respond_to do |format|
      format.js { render :partial => 'activiteitjs',:locals => {:activiteit=>@activiteit, :vrij=>@vrij}}
    end		
	end

  # GET /activities/1
  # GET /activities/1.xml
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.xml
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
		authorize! :update, @activity
  end

  # POST /activities
  # POST /activities.xml
  def create
    @activity = Activity.new(params[:activity])
		authorize! :create, @activity

    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(activities_url)  }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.xml
  def update
    @activity = Activity.find(params[:id])
		authorize! :update, @activity

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to(activities_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.xml
  def destroy
    @activity = Activity.find(params[:id])
		authorize! :destroy, @activity
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(activities_url) }
      format.xml  { head :ok }
    end
  end
end
