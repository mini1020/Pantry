class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, only: [:show] # deviseメソッド。ログインしていなければログイン画面にリダイレクトする
  before_action :admin_or_correct_user, only: [:show]
  
  def show
  end

  def edit_destroy_request
  end

  def update_destroy_request
  end

end
