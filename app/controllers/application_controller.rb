class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    # 追加したカラムを許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:uname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:uname])
    end

    private
    def set_user
      @user = User.find(params[:id])
    end
end
