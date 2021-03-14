Rails.application.routes.draw do

  root "homes#top"
  # get 'foods/new'
  # get 'storages/new'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  
  resources :users, only: [:show] do
    resources :storages do
      resources :foods
    end
  end
  
end
