class FirmsController < ApplicationController
  authorize_resource :firm
  
  skip_before_filter :authenticate_user!, :only => [:create]
  skip_before_filter :find_firm
  # GET /firms
  # GET /firms.xml
  def index
    @firms = Firm.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @firms }
    end
  end

  # GET /firms/1
  # GET /firms/1.xml
  def show
    
    @firm = Firm.find_by_subdomain!(request.subdomain)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @firm }
      format.js
    end
  end

  # GET /firms/new
  # GET /firms/new.xml
  def new
    @firm = Firm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @firm }
    end
  end

  # GET /firms/1/edit
  def edit
    @firm = Firm.find(params[:id])
  end

  # POST /firms
  # POST /firms.xml
  def create
    @firm = Firm.new(params[:firm])
	@firm.subdomain = @firm.subdomain.downcase
    respond_to do |format|
      if @firm.save
        flash[:notice] = 'Firm was successfully created! Now create the first user.'
        format.html { redirect_to(register_user_path(@firm)) }
        
      else
      	flash[:error] = 'Firm could not be created'
        format.html { render "public/register", :layout => "registration"}
        format.xml  { render :xml => @firm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /firms/1
  # PUT /firms/1.xml
  def update
    @firm = Firm.find(params[:id])

    respond_to do |format|
      if @firm.update_attributes(params[:firm])
        flash[:notice] = flash_helper('Firm was successfully updated.')
        format.html { redirect_to account_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @firm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /firms/1
  # DELETE /firms/1.xml
  def destroy
    @firm = Firm.find(params[:id])
    @firm.destroy

    respond_to do |format|
      format.html { redirect_to(firms_url) }
      format.xml  { head :ok }
    end
  end
  
end
