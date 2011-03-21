class ApplicationController < ActionController::Base
  helper :layout
  before_filter :require_user
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_user_session, :current_firm, :current_user, :find_firm
  
  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied."
  redirect_to root_path(:subdomain => current_firm.name)
  end
 
  private
  
  
 def login
    if @firm 
      return skip_before_filter :require_user, :only => [:new, :create]
    end
  end
  
  def find_firm
    return @firm if defined?(@firm)
    @firm = current_user.firm
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  def current_user  
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = login_path
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  
  
  def current_firm
    return @current_firm if defined?(@current_firm)
    @current_firm = current_user.firm
  end
  def require_firm
      unless current_firm
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end   
   end
end
