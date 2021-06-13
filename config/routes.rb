Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "homes#top"

  devise_for :admins, controllers: {  
    sessions: "admins/sessions"
  }
    namespace :admins do
      resources :users, only: [:index, :edit, :update, :destroy] do
        collection do
          get "destroy_request"
        end
      end
    end

  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks",
      passwords: "users/passwords",
      sessions: "users/sessions"
    }
  # ユーザー情報削除申請後のログアウト用
  devise_scope :user do
    get 'users/sign_out', to: 'users/sessions#destroy', as: :sign_out
  end

  resources :users, only: [:show] do
    member do
      get "edit_destroy_request"
      patch "update_destroy_request"
    end
    resources :storages, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  get "/users/:user_id/storages/foods/new", to: "foods#new", as: "new_user_storage_food"
  post "/users/:user_id/storages/foods", to: "foods#create", as: "user_storage_food"
  get "/users/:user_id/storages/foods", to: "foods#index", as: "user_storage_foods"
  get "/users/:user_id/storages/:storage_id/foods/:id/edit", to: "foods#edit", as: "edit_user_storage_food"
  patch "/users/:user_id/storages/:storage_id/foods/:id", to: "foods#update", as: "update_user_storage_food"
  delete "/users/:user_id/storages/:storage_id/foods/:id/", to: "foods#destroy", as: "destroy_user_storage_food"

end
