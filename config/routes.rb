Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" },
                     skip: [:registrations]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Landing page
  root "pages#home"

  # Onboarding
  resource :onboarding, only: [:show, :update], controller: "onboarding"

  # Resume upload
  resources :resumes, only: [:new, :create, :show]

  # Dashboard
  get "dashboard", to: "dashboard#show"

  # Career Reports
  resources :career_reports, only: [:show, :create] do
    member do
      get :download_pdf
      get :preview
    end
  end

  # Payments
  resources :payments, only: [:create] do
    collection do
      post :webhook
    end
  end
end
