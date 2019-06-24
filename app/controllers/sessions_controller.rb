class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      check_rememberme user
      flash[:danger] = t "controllers.sessions.login_success"
      redirect_back_or user
    else
      flash.now[:danger] = t "controllers.sessions.invalid"
      render :new
    end
  end

  def check_rememberme user
    return remember user if params[:session][:remember_me] == Settings.remember
    forget user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
