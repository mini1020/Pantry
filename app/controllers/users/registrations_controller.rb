# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, only: [:update, :destroy]
  # before_action :editable?, only: [:edit, :update]

  # GET /resource/sign_up
  def new
    super
    # @user = User.new
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    if by_admin_user?(params)
      # 管理者ユーザーからのアクセスの場合はURLからリソースを取得する
      self.resource = resource_class.to_adapter.get!(params[:id])
    else
      # 一般ユーザーの場合はcurrent_userから取得
      authenticate_scope!
      super
    end
  end

  # PUT /resource
  def update
    if by_admin_user?(params)
      self.resource = resource_class.to_adapter.get!(params[:id])
    else
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    end

    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)

    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      # リダイレクト先を指定
      respond_with resource, location: after_update_path_for(resource)
    else
      # passwordとpassword_confirmationをnilにする
      clean_up_passwords resource
      # validatable有効じに、パスワードの最小値を設定する
      set_minimum_password_length
      respond_with resource
    end
  end


  # DELETE /resource
  def destroy
    super
  end

  protected
    # 登録後の遷移先を指定
    def after_sign_up_path_for(resource)
      user_path
    end

    # 更新後の遷移先を指定
    def after_update_path_for(resource)
      # by_admin_user?(params) ? user_path(current_user) : user_path
      user_path
      end
    end

    #更新時はパスワードのバリデーションをスルーする
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

  private
    def by_admin_user?(params)
      params[:id].present? && current_user_is_admin?
    end
  
    def current_user_is_admin?
      user_signed_in? && current_user.admin?
    end

    # def editable?
    #   if !current_user_is_admin?
    #     raise CanCan::AccessDenied
    #   end
    # end


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
