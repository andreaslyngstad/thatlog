class ApplicationController < ActionController::Base

	include UrlHelper
  before_filter :set_mailer_url_options, :find_firm
	before_filter :authenticate_user!, :exept => [:after_sign_in_path_for, :sign_in_and_redirect, :check_firm_id, :current_subdomain]
  helper :layout
  helper_method :current_firm, :is_root_domain?, :can_sign_up?, :current_subdomain, :time_zone_now, :ftz
  skip_before_filter :find_firm, :only => [:sign_up_and_redirect]

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
   def current_subdomain
      if request.subdomains.first.present? && request.subdomains.first != "www"
        current_subdomain = Firm.find_by_subdomain(request.subdomains.first)
      else
        current_subdomain = nil
      end
      return current_subdomain
  end
  def after_sign_in_path_for(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    subdomain_name = current_user.firm.subdomain
    if current_subdomain.nil?
      # logout of root domain and login by token to subdomain
      token =  Devise.friendly_token
      current_user.loginable_token = token
      current_user.save
      sign_out(current_user)
      flash[:notice] = nil
      home_path = valid_user_url(token, :subdomain => subdomain_name)
      return home_path
    else
      if subdomain_name != current_subdomain.name
        # user not part of current_subdomain
        sign_out(current_user)
        flash[:notice] = nil
        flash[:alert] = "Sorry, invalid user or password for subdomain"
      end
    end
    super
  end
  def sign_up_and_redirect(firm)
      redirect_to statistics_path(:subdomain => firm.subdomain)

  end
  def find_firm
    subdom = request.subdomain
    if subdom.match(/^www|^WWW/)
     subdom = subdom.gsub(/^www.|^WWW./, '')
    end
      @firm = Firm.find_by_subdomain(subdom) || not_found
  end
   def not_found
      raise ActionController::RoutingError.new('Not Found')

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



  def check_firm_id
    return current_subdomain ? current_user.firm.id == current_subdomain.id : false
  end
  def time_range_to_day
  	(Time.now.midnight)..(Time.now.midnight + 1.day)
  end
  
  def check_log_status(params_log_id)
    if params_log_id != "0"
    @log = Log.find(params_log_id)
    end
    @firm = current_firm
    @customers = @firm.customers
  end
end
