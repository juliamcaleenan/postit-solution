class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :same_user?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:error] = 'You must be logged in'
      redirect_to root_path
    end
  end

  def same_user?(user)
    user == current_user
  end

  def require_same_user(user)
    unless user == current_user
      flash[:error] = 'You do not have permission to perform that action'
      redirect_to root_path
    end
  end
end
