class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user! # deviseメソッド。ログインしていなければログイン画面にリダイレクトする
  before_action :correct_user, only: [:edit_destroy_request, :update_destroy_request]
  before_action :admin_or_correct_user, only: [:show]
  
  def show
  end

  def edit_destroy_request
  end

  def update_destroy_request
    if @user.update(destroy_request_params)
      redirect_to sign_out_path
      # 削除申請が出されると管理者にメールが飛ぶようにしたい
    else
      render :edit_destory_request
    end
  end

  private
    def destroy_request_params
      params.require(:user).permit(:is_deleted)
    end
end
