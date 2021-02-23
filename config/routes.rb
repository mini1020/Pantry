Rails.application.routes.draw do
  root "homes#top"
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
end
