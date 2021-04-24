class StoragesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @storage = Storage.new
  end

  def create
    @user = User.find(params[:user_id])
    @storage = Storage.new(storage_params)
    if @storage.save
      flash[:success] = "保管場所を登録しました。"
      redirect_to root_url # 後でリダイレクト先を一覧ページに変更
    else
      render :new
    end
  end

  private
    def storage_params
      params.require(:storage).permit(:place, :user_id)
    end
end
