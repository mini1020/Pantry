class FoodsController < ApplicationController
  before_action :set_user
  before_action :set_food, only: [:edit, :update, :destroy]

  def index
    @storages = Storage.all
  end

  def new
    @storages = Storage.all
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

  end

  private
    def food_params
      params.require(:food).permit(:fname, :quantity, :purchase, :expiration, :notice, :storage_id)
    end

    def set_food
      @food = Food.find(params[:id])
    end

end
