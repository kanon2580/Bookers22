class UsersController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def index
    @new_book = Book.new
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(current_user)
    else
      @user = current_user
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to user_path(current_user)
    end
  end
end
