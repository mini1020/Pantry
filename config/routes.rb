Rails.application.routes.draw do

  root "homes#top"
  get 'foods/new'
  get 'storages/new'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  
end
