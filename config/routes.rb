Rails.application.routes.draw do
  root "homes#top"

  devise_for :admins, controllers: {  
    sessions: "admins/sessions"
  }
    namespace :admins do
     resources :users, only: [:index, :edit, :update, :destroy]
    end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  } 

  get "/users/:user_id/storages/foods/new", to: "foods#new", as: "new_user_storage_food"
  get "/users/:user_id/storages/foods", to: "foods#index", as: "user_storage_foods"

  resources :users, only: [:show] do
    resources :storages, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :foods, only: [:create, :edit, :update, :destroy]
    end
  end

end
