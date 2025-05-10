Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root "techniques#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  get "static_pages/top"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :techniques, only: %i[index] do
    get "search", on: :collection
    get "favorites", on: :member
  end
  namespace :techniques do
    resources :youtube, only: %i[new create show edit update destroy]
    resources :twitter, only: %i[new create show edit update destroy]
  end
  resources :favorites, only: %i[create destroy]
  resources :folders, only: %i[new create show edit update destroy]
end
