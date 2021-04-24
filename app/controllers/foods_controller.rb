class FoodsController < ApplicationController
  before_action :set_user

  def index
    @foods = Food.all
  end

  def new
  end
end
