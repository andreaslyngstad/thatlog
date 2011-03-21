class UsersController < ApplicationController 
  set_tab :users	
  before_filter :find_firm
  load_and_authorize_resource :firm
  load_and_authorize_resource :user, :through  => :firm
  
  
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
    @done_todos = @user.todos.where(["completed = ?", true]).includes(:project)
    @not_done_todos = @user.todos.where(["completed = ?", false]).includes(:project)
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
    
    @users = @firm.users.all
  end

  # POST /users
  # POST /users.xml
  
    def create
      @user = User.new(params[:user])
      @user.firm = @firm
      @users = @firm.users
      @model = "user"
      @model_instanse = @user
       respond_to do |format|
        if @user.save
          flash[:notice] = "Registration successful."
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
     @users = @firm.users.all
     @user = User.find(params[:id])
     @user.firm = @firm
      respond_to do |format|
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      format.html { redirect_to(users_path())}
      format.js
    else
      render :action => 'edit'
    end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
     respond_to do |format|
    if @user == current_user
    flash[:notice] = "You are logged in as #{@user.name}. You cannot delete your self."
      format.html{ redirect_to(users_path())}
      format.js
    else
    @user.destroy
   		flash[:notice] = "#{@user.name} was deleted."
      format.html { redirect_to(users_url()) }
      format.xml  { head :ok }
      format.js
    end
    end
  end
  

  
end
