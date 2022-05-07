class UsersController < ApplicationController
  
  before_action :get_user, only: [:destroy]
  before_action :check_authority, except: [:favorite_books]

  #GET /users
  def index
    @users = User.order(:created_at)
  end

  #GET /users/new
  def new
    @user = User.new
  end

  #POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User #{@user.email} is successfully created"
    else
      render "new"
    end
  end

  #DELETE /user/:id
  def destroy
    @user.destroy
    redirect_to users_path, notice: "User has been deleted"
  end

  #GET /user_favorites
  def favorite_books
    @books = current_user.books.includes(:authors)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end

  def get_user
    @user = User.find(params[:id])
  end

end
