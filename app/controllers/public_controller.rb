class PublicController < ApplicationController
  skip_before_filter :authenticate_user!
  layout "registration"
  def index
    
  end

  def register
    @firm = Firm.new
     
  end 
  
  def first_user
    @firm = Firm.find(params[:firm_id])
    @user = @firm.users.build
  end
  
  def create
    @user = User.new(params[:user])
    @firm = @user.firm
    @user.update_attributes(:manager => "true") 
        if @user.save
          flash[:notice] = "Registration successful."
         redirect_to(root_url(:subdomain => @firm.name))
        else
          render :action => 'first_user'
      end
  end
  def validates_uniqe
  	if !params[:subdomain].to_s.match(/^[a-z0-9\_]+$/i).nil?
	@firm = Firm.find_by_subdomain(params[:subdomain])
	else
	@wrong_format = true
	end
  end	
end
