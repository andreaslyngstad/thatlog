class ApplicationController < ActionController::Base
  helper :layout
  before_filter :authenticate_user!
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_firm, :find_firm
  
  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied"
  redirect_to root_path()
  end
 
  private

  def current_firm
    return @current_firm if defined?(@current_firm)
    @current_firm = current_user.firm
  end
  
end
