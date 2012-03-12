class UsersController < ApplicationController 

  skip_before_filter :authenticate_user!, :only => [:valid]
  
  # GET /users
  # GET /users.xml
  def index
  	@firm = current_firm
    @users = @firm.users.all
    @user = User.new
   
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @firm = current_firm
    @user = User.find(params[:id])
    @done_todos = @user.todos.where(["completed = ?", true]).includes(:project, :user)
    @not_done_todos = @user.todos.where(["completed = ?", false]).includes(:project, :user)
    
    @customers = @firm.customers.includes(:employees)
    @log = Log.new(:user => @user)
    @logs = @user.logs.where(:log_date => time_range_to_day).order("log_date DESC").includes([:user, :todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
    @all_projects = current_user.projects.where(["active = ?", true])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
      format.js
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @users = @firm.users.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @firm = current_firm
    @user = current_user
  end

  # POST /users
  # POST /users.xml
  
    def create
      @user = User.new(params[:user])
      @user.firm = current_firm
      @users = current_firm.users
      @model = "user"
      @model_instanse = @user
       respond_to do |format|
        if @user.save
          flash[:notice] = flash_helper("Registration successful.")
          format.html {redirect_to(users_path())}
          format.js
        else
          format.js { render "shared/validate_create" }
      end
      end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
     @users = current_firm.users.all
     @user = User.find(params[:id])
     @model = "user"
     @model_instanse = @user
      
      respond_to do |format|
    if @user.update_attributes(params[:user])
      flash[:notice] = flash_helper("Successfully updated profile.")
      format.html { redirect_to(user_path(@user))}
      format.js
    else
    	
      format.js { render "shared/validate_update" }
      flash[:notice] = flash_helper("something went wrong #{@user.errors}")
      format.html { redirect_to(edit_user_path(@user))}
    end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
     respond_to do |format|
    if @user == current_user
    flash[:notice] = flash_helper("You are logged in as #{@user.name}. You cannot delete your self.")
      format.html{ redirect_to(users_path())}
      format.js
    else
    @user.destroy
   		flash[:notice] = flash_helper("#{@user.name} was deleted.")
      format.html { redirect_to(users_url()) }
      format.xml  { head :ok }
      format.js
    end
    end
  end
  
  def valid

  	token_user = User.valid?(params)

    if token_user
      sign_in(:user, token_user)
      flash[:notice] = flash_helper("You have been logged in")
    else
      flash[:alert] = "Login could not be validated"
    end
    redirect_to statistics_path
  end
  
end
