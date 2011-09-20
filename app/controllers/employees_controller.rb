class EmployeesController < ApplicationController

  def create
    @employee = Employee.new(params[:employee])
	@customer = @employee.customer
    respond_to do |format|
      if @employee.save
        format.html { redirect_to(@employee, :notice => 'Employee was successfully created.') }
        format.xml  { render :xml => @employee, :status => :created, :location => @employee }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

 
  def update
    @employee = Employee.find(params[:id])
    @firm = current_user.firm
    @customer = @employee.customer
    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        flash[:notice] = flash_helper("Employee was successfully saved.")
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
       flash[:notice] = flash_helper("Employee was deleted.")
      format.html { redirect_to(employees_url) }
      format.xml  { head :ok }
      format.js
    end
  end
end
