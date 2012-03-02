class PasswordsController < Devise::PasswordsController
  skip_before_filter :find_firm
  def update
      self.resource = resource_class.reset_password_by_token(params[resource_name])
      if resource.errors.empty?
        sign_in(resource_name, resource)
        user = current_user
        sign_out(current_user)
        token =  Devise.friendly_token
        user.loginable_token = token
        user.save
        cookies[:token] = { :value => token, :domain => :all }
        redirect_to sign_in_at_subdomain_url(:subdomain => resource.firm.subdomain)
      else
        respond_with resource
      end
    end

end