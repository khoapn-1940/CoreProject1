class SessionsController < ApplicationController
  def new; end

  def home; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      success_login user
    else
      fail_login
    end
  end

  def destroy
    if logged_in?
      log_out
    end
    redirect_to root_url
  end

  private

  def success_login user
    log_in user
    if params[:session][:remember_me] == Settings.remember_me
      remember(user)
    else
      forget(user)
    end
    flash.now[:success] =
      t "authentication.controllers.sessions_controller.flash.login_success"
    render :home
  end

  def fail_login
    flash.now[:danger] =
      t "authentication.controllers.sessions_controller.flash.login_failed"
    render :new
  end
end
