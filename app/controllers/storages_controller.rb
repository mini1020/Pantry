class StoragesController < ApplicationController
  include AjaxHelper
  before_action :admin_not_viewable
  before_action :authenticate_user! 
  before_action :set_user
  before_action :set_storage, only: [:edit, :update, :destroy]

  def index
    @storages = Storage.where(user_id: current_user.id).page(params[:page]).per(5)
  end

  def new
    @storage = Storage.new
  end

  def create
    @storage = Storage.new(storage_params)
    respond_to do |format|
      if @storage.save
        format.html
        format.js { render ajax_redirect_to(user_storages_url), 
                    flash[:notice] = "#{@storage.place}を登録しました。" }
      else
        format.html { render :new }
        format.js { render "messages/storage_errors" }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @storage.update(storage_params)
        format.html
        format.js { render ajax_redirect_to(user_storages_url), 
                    flash[:notice] = "保管場所情報を更新しました。" }
      else
        format.html { render :edit }
        format.js { render "messages/storage_errors" }
      end
    end
  end

  def destroy
    @storage.destroy
    flash[:success] = "#{@storage.place}の情報を削除しました。"
    redirect_to user_storages_url
  end

  private
    def storage_params
      params.require(:storage).permit(:place, :user_id)
    end

end
