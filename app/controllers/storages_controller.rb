class StoragesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @storages = Storage.page(params[:page]).per(5)
  end

  def new
    @user = User.find(params[:user_id])
    @storage = Storage.new
  end

  def create
    @user = User.find(params[:user_id])
    @storage = Storage.new(storage_params)
    if @storage.save
      flash[:success] = "保管場所を登録しました。"
      redirect_to user_storages_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @storage = Storage.find(params[:id])
  end

  def update
    @storage = Storage.find(params[:id])
    if @storage.update(storage_params)
      flash[:success] = "保管場所情報を更新しました。"
      redirect_to user_storages_url
    else
      render :edit
    end
  end

  private
    def storage_params
      params.require(:storage).permit(:place, :user_id)
    end
end
