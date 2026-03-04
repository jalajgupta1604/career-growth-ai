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

  # Interview Prep
  get "interview-prep", to: "interview_prep#show", as: :interview_prep
  get "interview-prep/lessons/:id", to: "interview_prep#lesson", as: :interview_prep_lesson
  post "interview-prep/lessons/:lesson_id/start", to: "interview_prep#start_lesson", as: :interview_prep_start_lesson
  post "interview-prep/lessons/:lesson_id/complete", to: "interview_prep#complete_lesson", as: :interview_prep_complete_lesson

  # Payments (legacy)
  resources :payments, only: [:create] do
    collection do
      post :verify
      post :webhook
    end
  end

  # Subscriptions
  resource :subscriptions, only: [:new, :create] do
    collection do
      post :verify
      post :webhook
      get :manage
      post :cancel
    end
  end

  # Pricing page
  get "pricing", to: "pages#pricing", as: :pricing
end
