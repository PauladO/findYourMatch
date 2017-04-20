class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]
  def index
    @users = User.all
  end

  def show
  end

  def update
    User.toggle_admin(params[:id])
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
