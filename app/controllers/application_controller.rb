class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    # 追加したカラムを許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:uname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:uname])
    end

    # ログイン後の遷移先を指定
    def after_sign_in_path_for(resource)
      # ログイン前にアクセスしようとしていたページがあった場合はそのページに
      # なければ食品一覧ページに遷移
      stored_location_for(resource) || user_storage_foods_path(resource)
    end

  private
    def set_user
      @user = if params[:user_id].present?
                User.find(params[:user_id])
              else
                User.find(params[:id])
              end
    end

    def set_storage
      @storage = if params[:storage_id].present?
                    Storage.find(params[:storage_id])
                 else
                    Storage.find(params[:id])
                 end
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

    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:danger] = "アクセス権限がありません。"
        redirect_to root_url
      end
    end
end
