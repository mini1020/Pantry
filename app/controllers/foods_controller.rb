class FoodsController < ApplicationController
  include AjaxHelper

  before_action :set_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_storage, only: [:edit, :update, :destroy]
  before_action :set_storages, only: [:new, :create, :edit, :update]
  before_action :set_food, only: [:edit, :update, :destroy]

  def index
    @foods = current_user.foods.all.page(params[:page]).per(20)
    @storages = current_user.storages.all
  end

  def search
    if params[:storage_id].present?
      @foods = Food.where(storage_id: params[:storage_id])
      @storage = Storage.find(params[:storage_id])
    else
      @foods = current_user.foods.all
      @storage = current_user.storages.all
    end
    
    respond_to do |format|
      format.json { render json: { foods: @foods, storage: @storage } }
      format.html
    end
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    respond_to do |format|
      if @food.save
        format.html
        format.js { render ajax_redirect_to(user_storage_foods_url), 
                    flash[:notice] = "#{@food.fname}の情報を登録しました。" }
      else
        format.html { render :new }
        format.js { render "messages/food_errors" }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @food.update(food_params)
        if @food.quantity == 0
          @food.destroy # この時点で数量0の場合は削除処理を行う
          format.html
          format.js { render ajax_redirect_to(user_storage_foods_url), 
                      flash[:notice] = "#{@food.fname}を使い切りました。" }
        else
          format.html
          format.js { render ajax_redirect_to(user_storage_foods_url), 
                      flash[:notice] = "#{@food.fname}の情報を更新しました。" }
        end
      else
        format.html { render :edit }
        format.js { render "messages/food_errors" }
      end
    end
  end

  def destroy
    @food.destroy
    flash[:notice] = "#{@food.fname}の情報を削除しました。"
    redirect_to user_storage_foods_url(current_user)
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
