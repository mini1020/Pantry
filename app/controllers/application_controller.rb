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

    def admin_or_correct_user
      unless current_admin
        @user = User.find(params[:id])
        unless @user == current_user
          flash[:danger] = "アクセス権限がありません。"
          redirect_to root_url 
        end
      end
    end
end
