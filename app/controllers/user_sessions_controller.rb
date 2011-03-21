class UserSessionsController < ApplicationController
  skip_before_filter :require_user
    layout "registration"
  def new
    @user_session = UserSession.new
  end
  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      @firm = current_user.firm
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "successfully logged out"
    redirect_to root_url
  end

end
