class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user! # deviseメソッド。ログインしていなければログイン画面にリダイレクトする
  before_action :admin_or_correct_user, only: [:show]
  
  def show
  end

  def edit_destroy_request
  end

  def update_destroy_request
    if @user.update(destroy_request_params)
      flash[:success] = "ユーザー情報は1週間以内に削除されます。またのご利用をお待ちしています。"
      redirect_to destroy_user_session_path
      # ログアウト処理を行う
      # 削除申請が出されると管理者にメールが飛ぶ
    else
      render :edit_destory_request
    end
  end

  private
    def destroy_request_params
      params.require(:user).permit(:destroy_request)
    end
end
