Rails.application.routes.draw do
  get 'foods/new'
  get 'storages/new'
  root "homes#top"
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
end
