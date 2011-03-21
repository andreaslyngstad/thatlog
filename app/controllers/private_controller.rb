class PrivateController < ApplicationController
   set_tab :home, :only => %w(home)
  def index
    @customers = Customer.search(params[:search])
    @customer = Customer.new
  end
  
  def firm
    
     @firm = @user.firm
  
     @projects = @firm.projects.where(["active = ?", true]).includes(:todos => [:logs])
     
  end
  def statistics
    @firm = current_user.firm
    @users = @firm.users
    @all_projects = @firm.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
    @customers = @firm.customers
    @todos = @firm.todos.where(["completed = ?", false]).includes(:users)
    @logs = current_user.logs.where(["end_time <> ?", !nil]).includes([:todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}]).order("log_date DESC")
    if !current_user.logs.blank?
    @log = Log.where("end_time IS ?",nil).last
      if @log.nil?
        log = Log.new
        
        log.tracking = nil
        log.save     
        @log = log
      end
    else
    log = Log.new
   
    log.tracking = nil
    log.save     
    @log = log
    end
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
   @firm = current_user.firm
    @customers = @firm.customers
    if params[:log_id]
    @log = Log.find(params[:log_id])
    end
    if params[:project_id] != "0"
    @project = Project.find(params[:project_id])
    @todos = @project.todos.where(["completed = ?", false])
    else
    @todos = "Select a project"
    
    end
  end
  
  def activate_projects
  	@project = Project.find(params[:id])
  	if @project.active == true
  	@project.active = false
  	flash[:notice] = "Project is made inactive."
  	else
	@project.active = true
	flash[:notice] = "Project is made active."
	end  
	@project.save
  end
  
  def customer_employees
    if params[:log_id]
    @log = Log.find(params[:log_id])
    end
    if params[:customer_id] != "0"
    @customer = Customer.find(params[:customer_id])
    @employees = @customer.employees
    else
    @employees = "Select a customer"
    end
  end
  
  def get_logs
    @firm = current_user.firm
    @customers = @firm.customers
    @customer = Customer.find(params[:customer_id])
  
    @log = Log.new(:customer => @customer)
    @all_projects = @firm.projects.where(["customer_id IS ? OR customer_id IS ?", nil, @customer.id]).where(["active = ?", true])
    @logs = @customer.logs.includes([:todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
  end
  
  def get_logs_project
  	@firm = current_user.firm
  	@customers = @firm.customers.includes(:employees)
  	@project = Project.find(params[:project_id])
  	@log = Log.new(:project => @project)
  	@logs = @project.logs.includes([:todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
  	@all_projects = @firm.projects.where(["active = ?", true])
  	@todos = @project.todos.where(["completed = ?", false]).includes(:user)
  end
  
  def get_logs_user
  	@firm = current_user.firm
  	@customers = @firm.customers.includes(:employees)
  	@user = User.find(params[:user_id])
  	@log = Log.new(:user => @user)
  	@logs = @user.logs.includes([:todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
  	@all_projects = @firm.projects.where(["active = ?", true])
  	
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
    @customers = @firm.customers
    @all_projects = @firm.projects.where(["active = ?", true]).includes(:customer, {:todos => [:logs]})
    if params[:time] == "to_day"
    time_range = (Time.now.midnight)..(Time.now.midnight + 1.day)
    elsif params[:time] == "this_week"
    time_range = (Time.now.beginning_of_week)..(Time.now.midnight + 1.day)
    
    elsif params[:time] == "this_month"
    time_range = (Time.now.beginning_of_month)..(Time.now.midnight + 1.day)
  
    elsif params[:time] == "this_year"
    time_range = (Time.now.beginning_of_year)..(Time.now.midnight + 1.day)
   
    elsif params[:time] == "yesterday"
    time_range = (Time.now.midnight - 1.day)..(Time.now.midnight)
   
    elsif params[:time] == "last_week"
    time_range = (Time.now.beginning_of_week - 7.day)..(Time.now.beginning_of_week - 1.second)
    
    elsif params[:time] == "last_month"
    time_range = (Time.now.beginning_of_month - 1.month)..(Time.now.beginning_of_month)
    
    elsif params[:time] == "last_year"
    time_range = (Time.now.beginning_of_year - 1.year)..(Time.now.beginning_of_year)
   
    end
    @logs = Log.where(:log_date => time_range).order("log_date DESC").includes(:project, :todo, :user, :customer )
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

   




