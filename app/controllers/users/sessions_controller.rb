# frozen_string_literal: true
# 一般ユーザーログイン処理
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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
    # ログイン後の遷移先を指定
    def after_sign_in_path_for(resource)
      user_path(current_user)
    end
end
