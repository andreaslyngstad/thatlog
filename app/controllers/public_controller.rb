class PublicController < ApplicationController
  skip_before_filter :authenticate_user!, :find_firm
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
    @firm = Firm.find(params[:firm_id])
    @user.role = "Admin"
    @user.firm = @firm

        if @user.save
          flash[:notice] = "Registration successful."
          redirect_to statistics_path
        else
        	flash[:error] = "Registration could not be saved because:"
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
