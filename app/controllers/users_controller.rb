class UsersController < ApplicationController
  include IsAdmin
  before_action :is_admin?, only: :index
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]

  def index
    if !is_admin?
      redirect_to user_path(current_user.id)
    end
    @users = User.all
  end

  def show
    redirect_to user_path(current_user.id) if current_user != @user unless current_user.admin

    Match.generate unless !!@user.todays_match
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
