class FoodsController < ApplicationController
  before_action :set_user

  def index
    @storages = Storage.all
  end

  def new
  end

end
