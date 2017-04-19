class UsersController < ApplicationController
  # before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "User admin rights changed"
    else
      redirect_to users_path, notice: "Could not update user"
    end
  end

  private
    def user_params
      params.require(:user).permit(:admin, :id)
    end
end
