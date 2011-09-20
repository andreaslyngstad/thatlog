class MilestonesController < ApplicationController
  def show
     @milestone = Milestone.find(params[:id])
     
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @milestone }
    end
  end
  
  def create
    @milestone = Milestone.new(params[:milestone])
    @project = @milestone.project
    @firm = @project.firm 
    respond_to do |format|
      if @milestone.save
        flash[:notice] = flash_helper('Milestone was successfully created.')
        format.html { redirect_to(firm_project_path(@firm, @project)) }
        format.js { render :action => "create_success"}
        else
        
        format.html { redirect_to(firm_project_path(@firm, @project)) }
        format.xml  { render :xml => @log.errors, :status => :unprocessable_entity }
        format.js { render :action => "failure"}
      end
     end
  end
  
  def update
    @milestone = Milestone.find(params[:id])
    @project = @milestone.project
    @firm = @milestone.project.firm
    if @milestone.update_attributes!(params[:milestone])
      flash[:notice] = flash_helper('Milestone was successfully updated.')
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.html { render :action  => :edit } # edit.html.erb
        format.json { render :nothing =>  true }
      end
    end
  end

  def destroy
    @milestone = Milestone.find(params[:id])
    @project = @milestone.project
    @firm = @milestone.project.firm
    @milestone.destroy
    
    respond_to do |format|
      flash[:notice] = flash_helper('Milestone was successfully deleted.')
      format.html { redirect_to(firm_project_path(@firm, @project)) }
      format.js
    end
  end

end
