class HomesController < ApplicationController
before_action :user_or_admin_logged_in

  def top
  end

  private
    # ログイン後はトップページにアクセスさせない
    def user_or_admin_logged_in
      if admin_signed_in?
        redirect_to admins_users_url
      elsif user_signed_in?
        redirect_to user_storage_foods_url(current_user)
      end
    end
  
end
