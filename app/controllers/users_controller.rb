class UsersController < ApplicationController
  def index
    @new_book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
