class PrivateController < ApplicationController
   set_tab :home, :only => %w(statistics)
      authorize_resource :firm
  def index
    @customers = Customer.search(params[:search])
    @customer = Customer.new
  end
  
 
  def account
  
  	@firm = current_firm
  	@user = current_user
  end
  def firm_edit
  
  end
  def firm_update
    @firm = current_firm

    respond_to do |format|
      if @firm.update_attributes(params[:firm])
        flash[:notice] = flash_helper('Firm was successfully updated.')
        format.html { redirect_to account_path }
        format.xml  { head :ok }
      else
      	
        format.html { render :action => "firm_edit" }
        format.xml  { render :xml => @firm.errors, :status => :unprocessable_entity }
      end
    end
  end
  def statistics
    @firm = current_firm
    @log_week = current_firm.logs.where(:log_date => (Time.now.beginning_of_week + 1.second)..(Time.now.end_of_day)).group("date(log_date)").sum(:hours)
 	@logs_project = current_firm.logs.where(['log_date > ? AND project_id NOT ?', Time.now.beginning_of_week, nil]).group("project").sum(:hours)
    
    @logs_customer = current_firm.logs.where(['log_date > ? AND customer_id NOT ?', Time.now.beginning_of_week, nil]).group("customer").sum(:hours)
    @logs_user = current_firm.logs.where(['log_date > ?', Time.now.beginning_of_week]).group("user").sum(:hours)
  end
  def reports
  	
  	 @users = current_firm.users
  	 @projects = current_firm.projects
  	 @customers = current_firm.customers
  end
   def report_for
  	if !params[:user_id].blank?
  	@user = User.find(params[:user_id])
  	
  	@logs = @user.logs.where(:log_date => (params[:from].to_date + 1.second)..(params[:to].to_date.end_of_day))
  	@projects = @logs.project
  	@logs_hours_by_project = @logs.group("project_id", "date(log_date)")
  	@logs_hours_by_date = @logs.group("date(log_date)").sum(:hours)
  	
  	end
  	if !params[:project_id].blank?
  	@project = Project.find(params[:project_id])
  	end
  	if !params[:customer_id].blank?
  	@customer = Customer.find(params[:customer_id])
  	end
  end
  def timesheets
  	@user = current_firm.users.find(params[:user_id])
  	@users = current_firm.users
  	 @dates = (Time.now.beginning_of_week.to_date)..(Time.now.end_of_week.to_date)
  	 range = (Time.now.beginning_of_week.to_date)..(Time.now.beginning_of_week.to_date + 7.days)
  	 @log_project = @user.logs.where(:log_date => range).group("project_id").sum(:hours)

  	 
  	 @log_week = @user.logs.where(:log_date => range).group("date(log_date)").sum(:hours)
  	 @log_week_project = @user.logs.where(:log_date => range).group("project_id").group("date(log_date)").sum(:hours)
  	 @log_week_no_project = @user.logs.where(:log_date => range, :project_id => nil).group("date(log_date)").sum(:hours)
  	 @projects = @user.projects
  	 @all_projects = @projects
  	 @customers = current_firm.customers
  	 @log_total = @user.logs.where(:log_date => range).sum(:hours) 
  	 
  	 
  end
  
  def add_log_timesheet
    @log = Log.new(params[:log])
    @user = @log.user
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
      	@users = current_firm.users
  	 @dates = (Time.now.beginning_of_week.to_date)..(Time.now.end_of_week.to_date)
  	 range = (Time.now.beginning_of_week.to_date)..(Time.now.beginning_of_week.to_date + 7.days)
  	 @log_project = @user.logs.where(:log_date => range).group("project_id").sum(:hours)
  	 @log_week = @user.logs.where(:log_date => range).group("date(log_date)").sum(:hours)
  	 @log_week_project = @user.logs.where(:log_date => range).group("project_id").group("date(log_date)").sum(:hours)
  	 @projects = @user.projects
  	 @all_projects = @projects
  	 @customers = current_firm.customers
  	 @log_total = @user.logs.where(:log_date => range).sum(:hours) 
        flash[:notice] = flash_helper('Log was successfully created.')
        format.html { redirect_to(home_path(@log)) }
        format.xml  { render :xml => @log, :status => :created, :location => @log }
        format.js
      else
       format.js { render "shared/validate_create" }
      end
    end
  end
  
	def timesheet_logs_day
		@users = current_firm.users
		@user = current_firm.users.find(params[:user_id])
		@logs = @user.logs.where(:log_date => params[:date].to_time..params[:date].to_time.end_of_day)
		@all_projects = current_user.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
		@customers = current_firm.customers
	end
 	def add_hours_to_timesheet
 		@project = Project.find(params[:id])	
 		@date = params[:date]
 		@log = Log.new
 		@log.project = @project
 		@log.log_date = @date
 		@log.event = "Added on timesheet"
		@log.begin = @date.beginning_of_day
		@log.end =  @log.begin + params[:hours]
		
 	end
 	
 		
  def add_todo_to_logs
    @firm = current_user.firm
    if !params[:todo_id].nil?
    @todo = Todo.find(params[:todo_id]) 
    @log = Log.where("tracking = ?", true).last
    @log.todo = @todo
    @log.project = @todo.project
    if !@todo.project.customer.nil?
    @log.customer = @todo.project.customer
    else
    @log.customer = nil
    end
    @log.save
    else
    @log = Log.where("tracking = ?", true).last
    @log.todo = nil
    @log.project = nil
    @log.customer = nil
    @log.save
    end
  end


  def project_todos
  	@firm = current_firm
    @customers = @firm.customers
    if params[:project_id] != "0"
    @project = Project.find(params[:project_id])
    @todos = @project.todos.where(["completed = ?", false])
    else
    @todos = "Select a project"
    end
    if params[:log_id] and params[:log_id] != "0"
    @log = Log.find(params[:log_id])
    end
  	if params[:tracking] == "true"
  		@tracking = "tracking"
  	end
  end
  
  def customer_employees
	if params[:log_id] and params[:log_id] != "0"
	@log = Log.find(params[:log_id])
	end
	if params[:customer_id] != "0"
	@customer = Customer.find(params[:customer_id])
	@employees = @customer.employees
	else
	@employees = "Select a customer"
	end
	if params[:tracking] == "true"
		@tracking = "tracking"
	end
  end
  
  def activate_projects
  	@project = Project.find(params[:id])
  	if @project.active == true
  	@project.active = false
  	flash[:notice] = flash_helper("Project is made inactive.")
  	else
	@project.active = true
	flash[:notice] = flash_helper("Project is made active.")
	end  
	@project.save
  end
  

  
  def get_logs
    @firm = current_user.firm
    @customers = @firm.customers
    @customer = Customer.find(params[:customer_id])
  	@employees = @customer.employees
    @log = Log.new(:customer => @customer)
    @all_projects = current_user.projects.where(["customer_id IS ? OR customer_id IS ?", nil, @customer.id]).where(["active = ?", true])
    @logs = @customer.logs.where(:log_date => time_range_to_day).order("log_date DESC").includes([:todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
  end
  
  def get_logs_project
  	@firm = current_user.firm
  	@customers = @firm.customers.includes(:employees)
  	@project = Project.find(params[:project_id])
  	@log = Log.new(:project => @project)
  	@logs = @project.logs.where(:log_date => time_range_to_day).order("log_date DESC").includes([:user, :todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
  	@all_projects = current_user.projects.where(["active = ?", true])
  	@todos = @project.todos.where(["completed = ?", false]).includes(:user)
  end
  
  def get_logs_user
  	@firm = current_user.firm
  	@customers = @firm.customers.includes(:employees)
  	@user = User.find(params[:user_id])
  	@log = Log.new(:user => @user)
  	@logs = @user.logs.where(:log_date => time_range_to_day).order("log_date DESC").includes([:user, :todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
  	@all_projects = current_user.projects.where(["active = ?", true])
  	
  end
  
  def get_users_project
  	@firm = current_user.firm
  	@project = Project.find(params[:project_id])
  	@members = @project.users
    @not_members = @firm.users - @members
  end
  
  def get_employees
    @firm = current_user.firm
    @customer = Customer.find(params[:customer_id])
    @employees = @customer.employees
  end
  
  def logs_pr_date
    @firm = current_user.firm
    @customers = @firm.customers.includes(:employees)
    @all_projects = current_user.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
    
	    if params[:time] == "to_day"
	    time_range = (Time.now.midnight)..(Time.now.midnight + 1.day)
	    elsif params[:time] == "this_week"
	    time_range = (Time.now.beginning_of_week)..(Time.now.midnight + 1.day)
	    
	    elsif params[:time] == "this_month"
	    time_range = (Time.now.beginning_of_month)..(Time.now.midnight + 1.day)
	  
	    elsif params[:time] == "this_year"
	    time_range = (Time.now.beginning_of_year)..(Time.now.midnight + 1.day)
	   
	    elsif params[:time] == "yesterday"
	    time_range = (Time.now.midnight - 1.day)..(Time.now.midnight - 1.second)
	   
	    elsif params[:time] == "last_week"
	    time_range = (Time.now.beginning_of_week - 7.day)..(Time.now.beginning_of_week - 1.second)
	    
	    elsif params[:time] == "last_month"
	    time_range = (Time.now.beginning_of_month - 1.month)..(Time.now.beginning_of_month - 1.second)
	    
	    elsif params[:time] == "last_year"
	    time_range = (Time.now.beginning_of_year - 1.year)..(Time.now.beginning_of_year - 1.second)
	   
	    end
	    
	    if params[:url] == "logs"
	    	logs_on = current_user
		elsif params[:url] == "get_logs"
			logs_on = Customer.find(params[:id])
		elsif params[:url] == "get_logs_project"
			logs_on = Project.find(params[:id])
		elsif params[:url] == "get_logs_user"
			logs_on = User.find(params[:id])
		end
		
		@logs = logs_on.logs.where(:log_date => time_range).order("log_date DESC").includes(:project, :todo, :user, :customer,:employee )
  end
  def log_range
  	@firm = current_user.firm
    @customers = @firm.customers.includes(:employees)
    @all_projects = current_user.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
    if params[:from] == params[:to]
    	time_range = (Date.parse(params[:from]).midnight)..(Date.parse(params[:from]).midnight + 1.day - 1.second)
    else
  		time_range = ((Date.parse(params[:from]).midnight)..Date.parse(params[:to]).midnight + 1.day)
  	end
  	if params[:url] == "logs"
  		logs_on = current_user
  	elsif params[:url] == "get_logs"
  		logs_on = Customer.find(params[:id])	
  	elsif params[:url] == "get_logs_user"
  		logs_on = User.find(params[:id])
  	elsif params[:url] == "get_logs_project"
  		logs_on = Project.find(params[:id])
  	end
    	@logs = logs_on.logs.where(:log_date => time_range).order("log_date DESC").includes(:project, :todo, :user, :customer, :employee )
  end
  
  def mark_todo_done
    @firm = current_user.firm
    
    @todo = Todo.find(params[:id])
    @project = @todo.project
    if @todo.completed == true
      @todo.completed = false
    else
      @todo.completed = true
    end
    @done_todos = @project.todos.where(["completed = ?", true]).includes(:user)
    @not_done_todos = @project.todos.where(["completed = ?", false]).includes(:user)
    @todo.update_attributes(params[:todo])
    respond_to do |format|
      format.js
  end
  end
  
  def membership
  	@firm = current_user.firm
  	@project = Project.find(params[:project_id])
  	@user = User.find(params[:id])
  	if @project.users.include?(@user)
  		@project.users.delete(@user)
  	else
  		@project.users << @user
  	end
  	@members = @project.users
  	@not_members = @firm.users - @members
  	
  end
end

   




