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

  # Profile
  resource :profile, only: [:show, :edit, :update], controller: "profile"

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

  # Mock Interviews
  resources :mock_interviews, only: [:index, :new, :create, :show] do
    member do
      post :answer
    end
  end

  # Salary Negotiation
  resources :negotiations, only: [:index, :new, :create, :show]

  # ATS Scoring
  resource :ats_score, only: [:show, :create]

  # Offer Analysis
  resources :offer_analyses, only: [:index, :new, :create, :show]

  # Salary Crowdsourcing
  resources :salary_submissions, only: [:index, :new, :create]

  # Peer Benchmarks
  resource :peer_benchmark, only: [:show, :create]

  # Skill Demand Trends
  resources :skill_trends, only: [:index, :show] do
    collection do
      post :seed
    end
  end

  # Interview Experiences
  resources :interview_experiences, only: [:index, :new, :create, :show]

  # Referrals
  resource :referral, only: [:show] do
    post :apply
  end

  # LinkedIn Integration
  resource :linkedin_profile, only: [:show, :new, :create]

  # Job Recommendations
  resources :job_recommendations, only: [:index, :show] do
    collection do
      post :generate
    end
    member do
      post :save
      post :apply
    end
  end

  # Enterprise HR Analytics
  get "enterprise", to: "enterprise#dashboard", as: :enterprise_dashboard
  post "enterprise/refresh", to: "enterprise#refresh", as: :enterprise_refresh
  get "enterprise/members", to: "enterprise#manage_members", as: :enterprise_members
  post "enterprise/members", to: "enterprise#add_member", as: :enterprise_add_member
  delete "enterprise/members/:member_id", to: "enterprise#remove_member", as: :enterprise_remove_member

  # AI Career Coach
  resources :career_coach, only: [:index, :show, :create] do
    member do
      post :message
      post :archive
    end
  end

  # Pricing page
  get "pricing", to: "pages#pricing", as: :pricing
end
