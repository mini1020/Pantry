class FoodsController < ApplicationController
  include AjaxHelper
  before_action :admin_not_viewable
  before_action :authenticate_user! 
  before_action :set_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_storage, only: [:edit, :update, :destroy]
  before_action :set_storages, only: [:new, :create, :edit, :update]
  before_action :set_food, only: [:edit, :update, :destroy]
  before_action :set_notices, only: [:index, :notice]

  def index
    @foods = current_user.foods.all
    @storages = current_user.storages.all
  end

  def ajax
    if params[:search].present?
      @foods = Food.where(storage_id: params[:search])
      @storage = Storage.find(params[:search])
    else
      @foods = current_user.foods.all
      @storages = current_user.storages.all
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

  def notice
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

    def set_notices
      @notices = current_user.foods.where(expiration: Date.current.next_day).or(current_user.foods.where(expiration: Date.current.since(2.days)))
    end
end
