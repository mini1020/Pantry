class FoodsController < ApplicationController
  before_action :set_user
  before_action :set_storage, only: [:edit, :update, :destroy]
  before_action :set_storages, only: [:new, :create, :edit, :update]
  before_action :set_food, only: [:edit, :update, :destroy]

  def index
    @foods = current_user.foods.all.page(params[:page]).per(5)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:success] = "食品を登録しました。"
      redirect_to user_storage_foods_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @food.update(food_params)
      # この時点で数量0の場合は削除処理を行う
      if @food.quantity == 0
        @food.destroy
        flash[:success] = "#{@food.fname}を使い切りました。"
      else
        flash[:success] = "食品の情報を更新しました。"
      end
      redirect_to user_storage_foods_url
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    flash[:success] = "#{@food.fname}の情報を削除しました。"
    redirect_to user_storage_foods_url
  end

  private
    def food_params
      params.require(:food).permit(:fname, :quantity, :purchase, :expiration, :notice, :storage_id)
    end

    def set_food
      @food = Food.find(params[:id])
    end

    def set_storages
      @storages = Storage.where(user_id: current_user.id)
    end

end
