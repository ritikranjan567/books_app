class ApplicationController < ActionController::Base
  before_action :check_user_logged_in

  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].blank? 
  end

  def check_authority
    redirect_back fallback_location: root_url, notice: "You are unauthorize for this action" unless current_user.admin?
  end

  helper_method :current_user

  private

  def check_user_logged_in
    redirect_to new_session_path if session[:user_id].blank?
  end
end
