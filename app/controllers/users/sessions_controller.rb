# frozen_string_literal: true
# 一般ユーザーログイン処理
class Users::SessionsController < Devise::SessionsController
  before_action :admin_not_viewable
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
    path = Rails.application.routes.recognize_path(request.referer)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # ユーザー情報削除申請が出されていた場合は、フラッシュメッセージを変える
    if signed_out
      # 削除申請後はidがpashハッシュに含まれる
      if User.find(path[:id] || path[:user_id]).is_deleted
        set_flash_message! :notice, :delete_user_account
      else
        set_flash_message! :notice, :signed_out
      end
    end
    yield if block_given?
    respond_to_on_destroy
  end

  protected
    def reject_user
      if @user = User.find_by(email: params[:user][:email])
        if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
          flash[:notice] = "ユーザー情報削除申請済みです。再度ご登録をしてご利用ください。"
          redirect_to new_user_registration_url
        else
          flash[:notice] = "項目を入力してください。"
        end
      end
    end
end
