# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:edit, :update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit    
    super
  end

  # PUT /resource
  def update
    super
  end


  # DELETE /resource
  # def destroy
  #   super
  # end

  protected
    # 登録後の遷移先を指定
    def after_sign_up_path_for(resource)
      user_path(current_user)
    end

    # 更新後の遷移先を指定
    def after_update_path_for(resource)
      user_path(current_user)
    end

    #更新時はパスワードのバリデーションをスルーする
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
