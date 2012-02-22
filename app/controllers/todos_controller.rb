class TodosController < ApplicationController
  
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.xml
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create
    @todo = Todo.new(params[:todo])
    @project = @todo.project
    @firm = current_firm
    @todo.completed = false
    @done_todos = @project.todos.where(["completed = ?", true]).includes(:user)
    @not_done_todos = @project.todos.where(["completed = ?", false]).includes(:user)
    @todo_same_day = @project.todos.where(:due => @todo.due).first
    respond_to do |format|
      if @todo.save
        flash[:notice] = flash_helper('Todo was successfully created.')
        format.html { redirect_to(project_path(@project)) }
        format.xml  { render :xml => @todo, :status => :created, :location => @todo }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end
 
 
  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = Todo.find(params[:id])
    @firm = @todo.project.firm
    @project = @todo.project
    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        flash[:notice] = flash_helper('Todo was successfully updated.')
        format.html { redirect_to(@todo) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    @project = @todo.project
    @firm = @todo.project.firm
    @done_todos = @project.todos.where(["completed = ?", true]).includes(:user)
    @not_done_todos = @project.todos.where(["completed = ?", false]).includes(:user)
    flash[:notice] = flash_helper('Todo was successfully deleted.')
    respond_to do |format|
      format.html { redirect_to(firm_project_path(@firm, @project)) }  
      format.js
    end
  end
  
  
end
