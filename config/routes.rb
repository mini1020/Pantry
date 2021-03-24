Rails.application.routes.draw do
  root "homes#top"
  # ↓/users/sign_inがUserモデルの認証画面のURL
  devise_for :users, controllers: {
    # ↓devise/registrationsをusers/registrationsに
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end
  
  resources :users, only: [:show] do
    resources :storages do
      resources :foods
    end
  end
  
end
