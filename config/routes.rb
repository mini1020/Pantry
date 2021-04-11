Rails.application.routes.draw do
  root "homes#top"

  devise_for :admins, controllers: {  
    sessions: "admins/sessions"
  }
    namespace :admins do
     resources :users, only: [:index, :edit, :update, :destroy]
    end

  devise_for :users, controllers: {
    registrations: "devise/registrations",
    sessions: "devise/sessions",
    omniauth_callbacks: "devise/omniauth_callbacks"
  }
    resources :users, only: [:show] # do
    #   resources :storages do
    #     resources :foods
    #   end
    # end

  # devise_scope :user do
  #   get "users/:id/edit", to: "users/registrations#edit", as: :edit_other_user_registration
  #   match "users/:id", to: "users/registrations#update", via: [:patch, :put], as: :other_user_registration
  # end
  
end
