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

  # Daily Challenge & Streaks
  resource :daily_challenge, only: [:show] do
    post :submit
  end

  # Company Interview Packs
  get "company-packs", to: "company_packs#index", as: :company_packs
  get "company-packs/:slug", to: "company_packs#show", as: :company_pack

  # Interview Debriefs
  resources :interview_debriefs, only: [:index, :new, :create, :show]

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

  # Community
  resources :community, only: [:index, :create], controller: "community" do
    member do
      post :like
    end
  end

  # Company Reviews
  resources :company_reviews, only: [:index, :new, :create, :show]

  # Career Simulations
  resources :career_simulations, only: [:index, :new, :create, :show]

  # AI Resume Builder
  resources :resume_builder, only: [:index, :new, :create, :show]

  # Talent Marketplace
  resources :job_postings, only: [:index, :new, :create, :show] do
    member do
      post :apply
    end
  end

  # Peer Practice
  resources :peer_practice, only: [:index, :create] do
    member do
      post :join
      post :feedback
    end
  end

  # Study Groups
  resources :study_groups, only: [:index, :show, :create] do
    member do
      post :join
      post :leave
    end
  end

  # Coding Playground
  resources :coding_playground, only: [:index, :show] do
    collection do
      post :submit
    end
  end
  get "coding-playground/result/:id", to: "coding_playground#result", as: :coding_playground_result

  # AI Interview Simulator
  resources :interview_simulator, only: [:new, :create, :show] do
    member do
      post :answer
    end
  end

  # Spaced Repetition & Revision
  resources :revisions, only: [:index] do
    collection do
      get :practice
    end
    member do
      post :review
    end
  end

  # Public API Keys
  resources :api_keys, only: [:index, :create, :destroy]

  # Salary Trajectory Forecasting
  resources :salary_forecasts, only: [:index, :create, :show]

  # Mentor Matching
  resources :mentors, only: [:index, :create, :update]

  # Discussion Forums
  resources :discussions, only: [:index, :show, :create] do
    member do
      post :reply
    end
  end

  # Public API v1
  namespace :api do
    namespace :v1 do
      get "salary", to: "salary_intelligence#show"
      get "skills", to: "skill_demand#index"
      post "parse-resume", to: "resume_parsing#create"
    end
  end

  # Notifications
  resources :notifications, only: [:index] do
    member do
      post :mark_as_read
    end
    collection do
      post :mark_all_read
    end
  end

  # Admin Panel
  namespace :admin do
    root to: "dashboard#show"
    resources :users, only: [:index, :show] do
      member do
        post :toggle_admin
        post :toggle_subscription
      end
    end
    resources :moderation, only: [:index] do
      member do
        post :resolve
        post :dismiss
      end
    end
    get "revenue", to: "revenue#index", as: :revenue
    resources :audit_logs, only: [:index]
    get "analytics", to: "analytics#index", as: :analytics
    resources :cms, only: [:index, :new, :create, :edit, :update] do
      member do
        post :publish
        post :archive
      end
    end
    resources :webhooks, only: [:index], controller: "webhooks"
  end

  # Global Search
  get "search", to: "search#index", as: :search

  # Invoices & Billing
  resources :invoices, only: [:index, :show]

  # Data & Privacy (GDPR/DPDP)
  resource :data_export, only: [:show] do
    post :request_export
    post :request_deletion
    post :cancel_deletion
  end

  # Employer Portal
  namespace :employer do
    root to: "dashboard#show"
    get "register", to: "registrations#new", as: :registration
    post "register", to: "registrations#create"
    resources :jobs, except: [:destroy]
    resources :candidates, only: [:index] do
      collection do
        post :search
      end
    end
    resources :pipeline, only: [:index] do
      member do
        post :update_stage
      end
    end
  end

  # Skill Badges
  resources :badges, only: [:index]

  # Webhooks (user-facing)
  resources :webhooks, only: [:index, :create, :destroy]

  # Pricing page
  get "pricing", to: "pages#pricing", as: :pricing
end
