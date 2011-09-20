class LogsController < ApplicationController
  
  
 
  # GET /logs
  # GET /logs.xml
  def index
    @all_projects = current_user.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
    @customers = current_firm.customers
    
    @logs = current_user.logs.where(:log_date => time_range_to_day).order("log_date DESC").includes(:project, :todo, :user, :customer )
    if !current_user.logs.blank?
    @log = Log.where("end_time IS ?",nil).last
    if @log.nil?
       @log_new = Log.new
    end
 	else
 	 @log_new = Log.new
 	end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @logs }
      format.js
    end
  end

  # GET /logs/1
  # GET /logs/1.xml
  def show
    @log = Log.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @log }
    end
  end

  # GET /logs/new
  # GET /logs/new.xml
  def new
    @log = Log.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @log }
    end
  end

  # GET /logs/1/edit
  def edit
    @log = Log.find(params[:id])
  end

  # POST /logs
  # POST /logs.xml
  def create
    
    @log = Log.new(params[:log])
    @log.tracking = false
    @all_projects =  current_user.projects.where(["active = ?", true])
    @customers = current_firm.customers
    
    @log.firm = current_firm
 	 @model = "log"
      @model_instanse = @log
    if params[:done]
      if !@log.todo.nil?
         @log.todo.completed = true
         @log.todo.save
      end
    end
    
    respond_to do |format|
      if @log.save
        flash[:notice] = flash_helper('Log was successfully created.')
        format.html { redirect_to(home_path(@log)) }
        format.xml  { render :xml => @log, :status => :created, :location => @log }
        format.js
      else
       format.js { render "shared/validate_create" }
      end
    end
  end

  # PUT /logs/1
  # PUT /logs/1.xml
  def update
  	 	@log = Log.find(params[:id])
      @all_projects = current_user.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
      @customers = current_firm.customers
      @projects = current_firm.projects.where(["active = ?", true])
     
      @model = "log"
      @model_instanse = @log
     # regular update 
    if !@log.todo.nil?
      if params[:done] == "1" 
      	
         @log.todo.completed = true
         @log.todo.save!
       
      elsif params[:done].nil?
      	
         @log.todo.completed = false
         @log.todo.save!
      
    end
    end
    
    respond_to do |format|
      if @log.update_attributes!(params[:log])
        flash[:notice] = flash_helper("Log was successfully saved.")
       
        format.js
      else
        format.js { render "shared/validate_update" }
        
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.xml
  def destroy
    @log = Log.find(params[:id])
    @log.destroy
    
    respond_to do |format|
      flash[:notice] = flash_helper('Log was deleted.')
      format.html { redirect_to logs_path }
      format.xml  { head :ok }
      format.js
    end
  end
  def start_tracking
  	 # Start tracing
  	@all_projects =  current_user.projects.where(["active = ?", true])
    @customers = current_firm.customers
    
   	@log = Log.new(params[:log])
   	@log.user = current_user
    @log.firm = current_firm
      @log.tracking = true
      @log.begin_time = Time.now
      @log.log_date = DateTime.now
      if params[:done]
	      if !@log.todo.nil?
	         @log.todo.completed = true
	         @log.todo.save
	      end
      end
       respond_to do |format|
      if @log.save
        flash[:notice] = flash_helper('Log was successfully created.')
        format.js
      else
       format.js { render "shared/validate_create" }
      end
    end
    
  end
  def stop_tracking
		 # End tracking
	@all_projects =  current_user.projects.where(["active = ?", true])
    @customers = current_firm.customers
    @log_new = Log.new
  	@log = Log.find(params[:id])
    @log.end_time = Time.now
    
	    if !@log.todo.nil?
	      if params[:done] == "1" 
         @log.todo.completed = true
         @log.todo.save!
      		elsif params[:done].nil?
         @log.todo.completed = false
         @log.todo.save!
    		end
	    end    
	    respond_to do |format|
      if @log.update_attributes!(params[:log])
        flash[:notice] = flash_helper("Log was successfully saved.")
        format.js
      else
        format.js { render "shared/validate_update" }
        
      end
    end
    end
    
	
end
