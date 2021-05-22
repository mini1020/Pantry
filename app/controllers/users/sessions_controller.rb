# frozen_string_literal: true
# 一般ユーザーログイン処理
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
    def reject_user
      if @user = User.find_by(email: params[:user][:email])
        if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
          flash[:notice] = "ユーザー情報削除申請済みです。再度ご登録をしてご利用ください。"
          redirect_to new_user_registration_url
        else
          flash[:notice] = "項目を入力してください。"
        end
      end
    end
end
