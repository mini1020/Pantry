# 管理者
class Admins::UsersController < ApplicationController
before_action :set_user, only: [:edit, :update]
before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def edit
  end

  def update
    resource_updated = update_resource(@user, user_params)
    if resource_updated
      flash[:success] = "#{@user.uname}の情報を更新しました。"
      redirect_to admins_users_url
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:uname, :email, :password, :password_confirmation)
    end

  protected
    def update_resource(user, params)
      user.update_without_password(params)
    end
end