class CustomersController < ApplicationController
  load_and_authorize_resource :firm
  
  # GET /customers
  # GET /customers.xml
  def index
	@firm = current_firm
    @customers = current_firm.customers.order("name ASC")
    @customer = Customer.new  
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    @customer = current_firm.customers.find(params[:id])
    @customers = current_firm.customers
    @logs = @customer.logs.includes([:todo, :employee, {:customer => [:employees]}, {:project => [:customer, :todos]}])
    
    @log = Log.new(:customer => @customer)
    @employees = @customer.employees
    @employee = Employee.new(:customer => @customer)
    @projects = @customer.projects.where(["active = ?", true]).includes(:customer, :todos)
    
    @all_projects = current_firm.projects.where(["customer_id IS ? OR customer_id IS ? AND active = ?", nil, @customer.id, true])
    @project = Project.new(:customer => @customer)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
      format.js
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    @customer = Customer.new
     
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customers = current_firm.customers
    @customer.firm = current_firm
    @customer = Customer.find(params[:id])
    @logs = @customer.logs
    @log = Log.new(:customer => @customer)
  end

  # POST /customers
  # POST /customers.xml
  def create
  	@firm = current_firm
    @customer = Customer.new(params[:customer])
    @customer.firm = current_firm
    respond_to do |format|
      if @customer.save
      	flash[:notice] = flash_helper("#{@customer.name}" + " is added.")
      	format.js
        
      end
      end
     
  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    @customer = Customer.find(params[:id])
    @firm = current_firm
    
    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        flash[:notice] = flash_helper("#{@customer.name}" + " was successfully updated.")
        format.js
        
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
      respond_to do |format|
      flash[:notice] = flash_helper('Customer was successfully deleted.')
     format.html { redirect_to projects_path }
      format.js
    end
   
  end
  
  def create_project
    
    @project = Project.new(params[:project])
    @project.firm = @firm
      respond_to do |format|
      if @project.save
      flash[:notice] = flash_helper("Project is added.")
      format.js
      end
      end
  end
  
  def update_project
    
  end
  
end