class SessionsController < ApplicationController

  skip_before_action :check_user_logged_in, only: [:new, :create]

  #GET /sessions/new
  def new
  end

  #POST /sessions
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to books_path
    else
      flash.new.error = "Invalid Email or Password"
      render "new"
    end
  end

  #post /sessions/destroy
  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
