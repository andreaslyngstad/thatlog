class SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!
  skip_before_filter :find_firm
  def new
    resource = build_resource
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end
  #def create
  #   subdomain = request.subdomain
  #   resource = warden.authenticate!(auth_options)
  #   sign_in(resource_name, resource)
  #  if subdomain.present?
  #    set_flash_message(:notice, :signed_in) if is_navigational_format?
  #    redirect_to statistics_url
  #  else
  #    user = current_user
  #    sign_out(current_user)
  #    token =  Devise.friendly_token
  #    user.loginable_token = token
  #    user.save
  #    cookies[:token] = { :value => token, :domain => :all }
  #    redirect_to sign_in_at_subdomain_url(token, :subdomain => resource.firm.subdomain)
  #  end
  #end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out
    redirect_to root_url(:subdomain => nil)
  end

  def sign_in_at_subdomain
      token_user = User.valid_recover?(cookies[:token].to_s)
      cookies.delete(:token, :domain => :all)
    if token_user
      sign_in(token_user)

       flash[:notice] = "Signed in successfully"
      redirect_to statistics_path
    else
      flash[:alert] = "Login could not be validated"
      redirect_to root_url
    end

  end
end