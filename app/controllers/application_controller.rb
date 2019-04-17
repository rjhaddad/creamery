class ApplicationController < ActionController::Base
    private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_login
    unless current_user
      flash[:danger] = "You must be logged in to access this."
      redirect_to login_url
    end
  end
  
  def check_session
    if current_user.present?
      flash[:warning] = "You already have an account."
      redirect_to '/'
    end
  end
  
  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end
end
