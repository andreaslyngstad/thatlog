class LogsController < ApplicationController
  
  load_and_authorize_resource :firm
  load_and_authorize_resource :customer
  authorize_resource :log, :through  => [:firm,:customer]
 
  # GET /logs
  # GET /logs.xml
  def index
    
    
    @all_projects = current_firm.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
    @customers = current_firm.customers
    time_range = (Time.now.midnight)..(Time.now.midnight + 1.day)
    @logs = Log.where(:log_date => time_range).order("log_date DESC").includes(:project, :todo, :user, :customer )
    if !current_user.logs.blank?
    @log = Log.where("end_time IS ?",nil).last
      if @log.nil?
        log = Log.new
        log.user = current_user
        log.firm = @firm
        log.tracking = nil
        log.save     
        @log = log
      end
    else
    log = Log.new
   	log.user = current_user
   	log.firm = @firm
    log.tracking = nil
    log.save     
    @log = log
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
    @log.user = current_user
    @log.tracking = false
    @all_projects =  current_firm.projects.where(["active = ?", true])
    @customers = current_firm.customers
    @log.user = current_user
    @log.firm = current_firm
    if params[:done]
      if !@log.todo.nil?
         @log.todo.completed = true
         @log.todo.save
      end
    end
    
    respond_to do |format|
      if @log.save
        flash[:notice] = 'Log was successfully created.'
        format.html { redirect_to(home_path(@log)) }
        format.xml  { render :xml => @log, :status => :created, :location => @log }
        format.js
      else
        flash[:error] = 'Please write something'
        format.html { redirect_to(firm_customer_path(@firm, @customer)) }
        format.xml  { render :xml => @log.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /logs/1
  # PUT /logs/1.xml
  def update
      @all_projects = current_firm.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
      @customers = current_firm.customers
      @projects = current_firm.projects.where(["active = ?", true])
      @log = Log.find(params[:id])
     # regular update 
     if !@log.todo.nil?
      if params[:done]
         @log.todo.completed = true
         @log.todo.save
      elsif !params[:done]
         @log.todo.completed = false
         @log.todo.save
      end
    end
    if !@log.begin_time.nil? and !@log.end_time.nil?
      
      
      @log.update_attributes(params[:log])
    end
    
    # Start tracing
   if @log.tracking.nil? and @log.begin_time.nil?
      @log.tracking = true
      @log.begin_time = Time.now
      @log.update_attributes(params[:log])
  
    
    # End tracking
   elsif @log.tracking == true and @log.end_time.nil?
      @log.end_time = Time.now
      @log.log_date = Time.now
      
      @log.update_attributes(params[:log]) 
      @log = Log.new
      @log.tracking = nil
      @log.save
    end
   
    
    respond_to do |format|
      if @log.update_attributes(params[@log])
        flash[:notice] = "Log was successfully saved."
       
        format.js
      else
        
        
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.xml
  def destroy
    @log = Log.find(params[:id])
    @log.destroy
    
    respond_to do |format|
      flash[:notice] = 'Log was deleted.'
      format.html { redirect_to logs_path }
      format.xml  { head :ok }
      format.js
    end
  end
  
end
