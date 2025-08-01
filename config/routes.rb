Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root "static_pages#about"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  get "static_pages/top"
  get "static_pages/about"
  get "static_pages/terms"
  get "static_pages/privacy_policy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :techniques, only: %i[index] do
    get "autocomplete", on: :collection
    get "search", on: :collection
    get "favorites", on: :member
  end
  namespace :techniques do
    resources :youtube, only: %i[new create show edit update destroy]
    resources :twitter, only: %i[new create show edit update destroy]
  end
  resources :favorites, only: %i[create destroy]
  resources :folders, only: %i[new create show edit update destroy]
  resources :categories, only: %i[index show] do
    member do
      post "follow", to: "follows#create"
      delete "unfollow", to: "follows#destroy"
    end
  end
  get "/youtube/title", to: "youtube_api#title"
end
