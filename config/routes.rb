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

  resources :users, only: [:show] do
    resources :storages do
      resources :foods
    end
  end
end
