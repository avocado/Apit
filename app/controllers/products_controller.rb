class ProductsController < ApplicationController
	before_filter :webmaster?, :except => [:index, :add, :substract]
  
  # GET /activities
  # GET /activities.xml
  def index
    @products = Product.find(:all, :order => "`name` ASC")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

	def add
    @product = Product.find(params[:id])
			@sub = current_user.boughts.find_by_product_id(@product.id)
			if @sub.nil?
				@sub = Bought.new(:user=>current_user,:product=>@product,:aantal=>1)
				#Notifier.deliver_ingeschreven_voor(@product,current_user)  
			else
				@sub.aantal||=0
				@sub.aantal+=1
			end
			@sub.save!
    respond_to do |format|
      format.js { render :partial => 'productjs',:locals => {:product=>@product}}
    end		
	end
	
	def substract
    @product = Product.find(params[:id])

		@sub = current_user.boughts.find_by_product_id(@product.id)
		if @sub.nil?
			#all good
		else
			if @sub.aantal>1
				@sub.aantal-=1
				@sub.save!
			else
				@sub.delete
			end
		end

    respond_to do |format|
      format.js { render :partial => 'productjs',:locals => {:product=>@product}}
    end		
	end

  # GET /activities/1
  # GET /activities/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /activities/new
  # GET /activities/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /activities/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /activities
  # POST /activities.xml
  def create
    @product = Product.new(params[:activity])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(products_url)  }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to(products_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
    end
  end
end
