# frozen_string_literal: true
# 管理者ログイン処理
class Admins::SessionsController < Devise::SessionsController
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
      stored_location_for(resource) || admins_users_path
    end

end
