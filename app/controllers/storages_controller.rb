class StoragesController < ApplicationController
  before_action :set_user
  before_action :set_storage, only: [:edit, :update, :destroy]

  def index
    @storages = Storage.page(params[:page]).per(5)
  end

  def new
    @storage = Storage.new
  end

  def create
    @storage = Storage.new(storage_params)
    if @storage.save
      flash[:success] = "保管場所を登録しました。"
      redirect_to user_storages_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @storage.update(storage_params)
      flash[:success] = "保管場所情報を更新しました。"
      redirect_to user_storages_url
    else
      # flash[:danger] = "更新をキャンセルしました。未入力の項目があります。"
      render :edit
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
