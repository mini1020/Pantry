# 管理者
class Admins::UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :destroy]
before_action :general_user_not_viewable
before_action :set_destroy_users, only: [:index, :destroy_request, :bulk_deletion]
before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  #管理者側からのユーザー情報編集ページ
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

  def destroy_request
  end

  def bulk_deletion #ユーザー情報一括削除
    ActiveRecord::Base.transaction do
      @destroy_users.each do |user|
        user.destroy!
      end
    end
    flash[:success] = "依頼されたユーザー情報を削除しました。"
    redirect_to admins_users_url
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.uname}の情報を削除しました。"
    redirect_to admins_users_url
  end

  private
    def user_params
      params.require(:user).permit(:uname, :email, :password, :password_confirmation)
    end

    def set_destroy_users
      @destroy_users = User.where(is_deleted: true)
    end

  protected
    def update_resource(user, params)
      user.update_without_password(params)
    end
end