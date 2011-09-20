class ApplicationController < ActionController::Base
	include UrlHelper
	 before_filter :authenticate_user!, :exept => [:after_sign_in_path_for, :sign_in_and_redirect, :check_firm_id, :current_subdomain] 
  helper :layout
  helper_method :current_firm, :is_root_domain?, :can_sign_up?, :find_firm, :current_subdomain, :time_zone_now, :ftz
  before_filter :set_mailer_url_options
 
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  
  
  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied"
  redirect_to root_path()
  end
  def can_sign_up?
    # return true if config.allow_account_sign_up is set to true
  	# Used in conjection with is_root_domain? for root domain.
    is_root_domain? ? true :Account::CAN_SIGN_UP
  end
  
  def is_root_domain?
    # return true if there is no subdomain
    result = (request.subdomains.first.present? && request.subdomains.first != "www") ? false : true
  end

  def current_subdomain
    # If subdomain is present, returns the account, else nil
    if !is_root_domain?
      current_subdomain = Firm.find_by_subdomain(request.subdomains.first)
      if current_subdomain.nil?
        redirect_to root_url(:account => false, :alert => "Unknown subdomain")
      end
    else 
      current_subdomain = nil
    end
    return current_subdomain
  end  
   def flash_helper(message)
  	return ("<span style='color:#FFF'>" + message + "</span>").html_safe
  	
  end 
  def time_zone_now
  	#exchange for Time.now
  	Time.zone = current_firm.time_zone
  	return Time.now.in_time_zone
  end
  
  def ftz(time)
	time.in_time_zone(current_firm.time_zone)
  end

     
  private

  def current_firm
    return @current_firm if defined?(@current_firm)
    @current_firm = current_user.firm
  end
  
  protected
  
  def authenticate_user!
    # An override to devise to redirect to custom page if config 
    if Rails.application.config.authenticate_to_home
      unless user_signed_in?
        redirect_to root_url, :alert => "You must be logged in to access that page - #{params[:controller]}"
        return false
      end
    else
      super
    end
  end
  
   def after_sign_in_path_for(resource_or_scope)
    # Modified to redirect user to their account root if login is at root domain
  	# User is signed out of that domain and signed in to their domain using a token.
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    account_name = current_user.firm.subdomain
    if current_subdomain.nil? 
      # logout of root domain and login by token to account
      token =  Devise.friendly_token
      current_user.loginable_token = token
      current_user.save
      sign_out(current_user)
      flash[:notice] = :nil
      account_path = valid_user_url(token, :subdomain => account_name)
      return account_path 
    end
    super
  end
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    # Handles case if user is visiting another subdomain and tries to sign in.
  	# Also handles the redirect on sign up, sending them to their account root.
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    if check_firm_id
      redirect_to stored_location_for(scope) || after_sign_in_path_for(resource)
    else
      account_name = current_user.firm.subdomain
      token =  Devise.friendly_token
      current_user.loginable_token = token
      current_user.save
      sign_out(current_user)
      flash[:notice] = nil
      account_path = valid_user_url(token, :subdomain => account_name)
      redirect_to account_path
    end
  end  

  def check_firm_id
    return current_subdomain ? current_user.firm.id == current_subdomain.id : false
  end
  def time_range_to_day
  	(Time.now.midnight)..(Time.now.midnight + 1.day)
  end
  
end
