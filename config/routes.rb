Rails.application.routes.draw do
  root "homes#top"

  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }
    
    resources :users, only: [:index, :destroy]
  
  # ↓/users/sign_inがUserモデルの認証画面のURL
  devise_for :users, controllers: {
    # ↓devise/registrationsをusers/registrationsに
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }
    resources :users, only: [:show] do
      resources :storages do
        resources :foods
      end
    end

  devise_scope :user do
    get "users/:id/edit", to: "users/registrations#edit", as: :edit_other_user_registration
    match "users/:id", to: "users/registrations#update", via: [:patch, :put], as: :other_user_registration
  end
  
  
  
end
