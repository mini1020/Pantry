# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update
    # トークンの照合を行う(reset_password_by_token)
    self.resource = resource_class.reset_password_by_token(resource_params)

    # updateメソッド実行時にブロックが渡されていればtrue、渡されていなければfalseを返す
    # ブロック → do…end, {…}で囲まれたコードの断片
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      # respond_with resource, location: after_resetting_password_path_for(resource)
      redirect_to after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      # respond_with resource
      render action: :edit
    end
  end

  protected
    def after_resetting_password_path_for(resource)
      super(resource)
      # Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
    end
    
  # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      # パスワードリセット通知を送信後、ログイン画面に遷移する
      super(resource_name)
    end
end
