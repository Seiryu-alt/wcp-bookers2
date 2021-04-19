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
    unless @user == current_user 
      flash[:alert] = "Access denied"
      redirect_back fallback_location: user_path(current_user)
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to user_path(user)
    else
      @user = user
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end