# 管理者
class Admins::UsersController < ApplicationController
before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:uname, :email, :password, :password_confirmation)
    end
end