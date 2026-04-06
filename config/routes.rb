Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  namespace :instructor do
    resources :dashboard, only: [:index]
  end

  namespace :learner do
    resources :dashboard, only: [:index]
  end

  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
