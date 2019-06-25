module SessionsHelper
  def log_in user
    session[:user_id] = user.id
    session[:role] = user.role
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:role] = user.role
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete([:user_id, :role, :remember_token])
  end

  def current_user? user
    user == current_user
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user
        if user.authenticated?(:remember, cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget(current_user)
    session.clear
    @current_user = nil
  end
end
