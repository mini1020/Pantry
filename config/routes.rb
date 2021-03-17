Rails.application.routes.draw do

  root "homes#top"
  devise_for :users, controllers: {
    # ↓registrations_controller.rbで記述する内容を有効にするために必要！
    registrations: "users/registrations",
    omniauth_callbacks: "omniauth_callbacks"
  }
  
  resources :users, only: [:show] do
    resources :storages do
      resources :foods
    end
  end
  
end
