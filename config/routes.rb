Rails.application.routes.draw do
  root "homes#top"
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
  
end
