class PublicController < ApplicationController
  skip_before_filter :authenticate_user!
  layout "registration"
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  before_filter :allow_params_authentication!, :only => :create
  include Devise::Controllers::InternalHelpers
  def index
    resource = build_resource
    clean_up_passwords(resource)
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
    @user.update_attributes(:role => "Admin") 
        if @user.save
          flash[:notice] = "Registration successful."
         sign_in_and_redirect(@user)
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
