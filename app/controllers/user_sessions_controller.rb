class UserSessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!
    layout "registration"
  def new
   
  end
  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      @firm = current_user.firm
      flash[:notice] = flash_helper("Successfully logged in.")

    else
      render :action => 'new'
    end
  end
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = flash_helper("successfully logged out")
    redirect_to root_url
  end

end
