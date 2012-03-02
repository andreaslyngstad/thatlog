require "devise"
class SubdomainLogin
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

  def sign_in_and_redirect(user, firm)
  redirect_to statistics_path(:subdomain => firm.subdomain)
  sign_in(user)
  end
end