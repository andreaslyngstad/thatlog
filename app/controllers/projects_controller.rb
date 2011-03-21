class ProjectsController < ApplicationController
  load_and_authorize_resource :firm
  set_tab :projects
	
  def index
  	@firm = current_firm
    @projects = @firm.projects.where(["active = ?", true])
    @customers = @firm.customers
    @project = Project.new
    @todo = Todo.new
    
  end
  def archive
  
  	@projects = current_firm.projects.where(["active = ?", false])
  	
  end

  def show
  	
    @project = current_firm.projects.find(params[:id])  
    @milestone = Milestone.new(:project => @project)
    @milestones = @project.milestones
    @todo = Todo.new(:project => @project)
    @done_todos = @project.todos.where(["completed = ?", true]).includes(:user)
    @not_done_todos = @project.todos.where(["completed = ?", false]).includes(:user)
    
  end

  def edit
    
  end

  def create
    @project = Project.new(params[:project])
    @project.firm = current_firm
    @project.active = true
    @project.users << current_user
      respond_to do |format|
      if @project.save
      flash[:notice] = "Project is added."
      format.js
      end
      end
  end
  
  def create_index
    @project = Project.new(params[:project])
   
    @project.active = true
    @project.users << current_user
    @project.firm = current_firm
      respond_to do |format|
      if @project.save
      flash[:notice] = "Project is added."
      format.js
      end
      end
  end

  def update
    @project = Project.find(params[:id])
    @customers = current_firm.customers
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = "Project was successfully saved."
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  def update_index
  	@project = Project.find(params[:id])
   @customers = current_firm.customers
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = "Project was successfully saved."
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
   @project = Project.find(params[:id])
   @project.todos.destroy_all 
   @project.logs.destroy_all
   @project.destroy
    
    respond_to do |format|
      flash[:notice] = 'Project was deleted.'
      format.html { redirect_to projects_path }
      format.js
    end
  end
end
