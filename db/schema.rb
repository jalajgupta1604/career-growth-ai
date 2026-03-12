# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_03_12_124759) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "career_reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "salary_gap_percentage"
    t.jsonb "skill_gap_data"
    t.jsonb "roadmap_data"
    t.float "interview_score"
    t.integer "payment_status", default: 0
    t.string "pdf_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_career_reports_on_user_id"
  end

  create_table "challenge_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "daily_challenge_id", null: false
    t.jsonb "answer_data", default: {}
    t.integer "score", default: 0
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_challenge_id"], name: "index_challenge_attempts_on_daily_challenge_id"
    t.index ["user_id", "daily_challenge_id"], name: "index_challenge_attempts_on_user_id_and_daily_challenge_id", unique: true
    t.index ["user_id"], name: "index_challenge_attempts_on_user_id"
  end

  create_table "coach_conversations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "topic"
    t.string "status", default: "active"
    t.jsonb "context_data", default: {}
    t.integer "messages_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_coach_conversations_on_status"
    t.index ["user_id", "created_at"], name: "index_coach_conversations_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_coach_conversations_on_user_id"
  end

  create_table "coach_messages", force: :cascade do |t|
    t.bigint "coach_conversation_id", null: false
    t.string "role", null: false
    t.text "content", null: false
    t.jsonb "metadata", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_conversation_id"], name: "index_coach_messages_on_coach_conversation_id"
    t.index ["created_at"], name: "index_coach_messages_on_created_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "domain"
    t.string "industry"
    t.string "size_range"
    t.string "city"
    t.string "plan_type", default: "basic"
    t.integer "max_seats", default: 10
    t.jsonb "settings", default: {}
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_companies_on_active"
    t.index ["domain"], name: "index_companies_on_domain", unique: true
  end

  create_table "company_analytics_snapshots", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "period", null: false
    t.jsonb "salary_data", default: {}
    t.jsonb "skill_data", default: {}
    t.jsonb "hiring_data", default: {}
    t.jsonb "benchmark_data", default: {}
    t.jsonb "attrition_data", default: {}
    t.integer "team_size"
    t.float "avg_salary"
    t.float "avg_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "period"], name: "idx_company_analytics_period", unique: true
    t.index ["company_id"], name: "index_company_analytics_snapshots_on_company_id"
  end

  create_table "company_members", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "member"
    t.datetime "invited_at"
    t.datetime "joined_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "user_id"], name: "index_company_members_on_company_id_and_user_id", unique: true
    t.index ["company_id"], name: "index_company_members_on_company_id"
    t.index ["role"], name: "index_company_members_on_role"
    t.index ["user_id"], name: "index_company_members_on_user_id"
  end

  create_table "company_packs", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "logo_icon"
    t.string "difficulty_level", default: "medium"
    t.jsonb "interview_rounds", default: []
    t.jsonb "tips_data", default: []
    t.jsonb "questions_data", default: []
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_company_packs_on_slug", unique: true
  end

  create_table "daily_challenges", force: :cascade do |t|
    t.date "challenge_date", null: false
    t.string "challenge_type", null: false
    t.jsonb "question_data", default: {}, null: false
    t.string "difficulty", default: "medium", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_date"], name: "index_daily_challenges_on_challenge_date", unique: true
  end

  create_table "interview_debriefs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name", null: false
    t.string "role_applied"
    t.date "interview_date"
    t.jsonb "questions_data", default: []
    t.text "user_notes"
    t.jsonb "ai_analysis", default: {}
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_interview_debriefs_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_interview_debriefs_on_user_id"
  end

  create_table "interview_experiences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name", null: false
    t.string "role", null: false
    t.string "difficulty", default: "medium"
    t.string "outcome"
    t.integer "rounds_count"
    t.integer "overall_rating"
    t.text "experience_summary"
    t.jsonb "rounds_data", default: []
    t.jsonb "tags", default: []
    t.boolean "anonymous", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_name", "role"], name: "idx_interview_exp_company_role"
    t.index ["created_at"], name: "index_interview_experiences_on_created_at"
    t.index ["difficulty"], name: "index_interview_experiences_on_difficulty"
    t.index ["outcome"], name: "index_interview_experiences_on_outcome"
    t.index ["user_id"], name: "index_interview_experiences_on_user_id"
  end

  create_table "job_listings", force: :cascade do |t|
    t.string "title", null: false
    t.string "company_name", null: false
    t.string "location"
    t.string "job_type"
    t.decimal "min_salary", precision: 12, scale: 2
    t.decimal "max_salary", precision: 12, scale: 2
    t.text "description"
    t.jsonb "required_skills", default: []
    t.jsonb "preferred_skills", default: []
    t.string "experience_range"
    t.string "source"
    t.string "source_url"
    t.boolean "active", default: true
    t.datetime "posted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_job_listings_on_active"
    t.index ["location"], name: "index_job_listings_on_location"
    t.index ["title", "company_name"], name: "index_job_listings_on_title_and_company_name"
  end

  create_table "job_recommendations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_listing_id", null: false
    t.float "match_score"
    t.jsonb "match_reasons", default: []
    t.jsonb "skill_matches", default: {}
    t.string "status", default: "new"
    t.datetime "viewed_at"
    t.datetime "applied_at"
    t.datetime "saved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_listing_id"], name: "index_job_recommendations_on_job_listing_id"
    t.index ["status"], name: "index_job_recommendations_on_status"
    t.index ["user_id", "job_listing_id"], name: "idx_job_recs_user_listing", unique: true
    t.index ["user_id", "match_score"], name: "index_job_recommendations_on_user_id_and_match_score"
    t.index ["user_id"], name: "index_job_recommendations_on_user_id"
  end

  create_table "lesson_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "prep_lesson_id", null: false
    t.integer "status", default: 0, null: false
    t.integer "time_spent_minutes", default: 0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.jsonb "notes_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prep_lesson_id"], name: "index_lesson_progresses_on_prep_lesson_id"
    t.index ["user_id", "prep_lesson_id"], name: "index_lesson_progresses_on_user_id_and_prep_lesson_id", unique: true
    t.index ["user_id"], name: "index_lesson_progresses_on_user_id"
  end

  create_table "linkedin_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "linkedin_uid"
    t.string "linkedin_url"
    t.string "headline"
    t.string "industry"
    t.string "location"
    t.integer "connections_count"
    t.jsonb "positions_data", default: []
    t.jsonb "education_data", default: []
    t.jsonb "skills_data", default: []
    t.jsonb "certifications_data", default: []
    t.jsonb "raw_profile_data", default: {}
    t.string "sync_status", default: "pending"
    t.datetime "last_synced_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linkedin_uid"], name: "index_linkedin_profiles_on_linkedin_uid", unique: true
    t.index ["user_id"], name: "index_linkedin_profiles_on_user_id", unique: true
  end

  create_table "mock_interviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "interview_type", default: "technical", null: false
    t.string "difficulty", default: "medium", null: false
    t.string "target_role"
    t.integer "status", default: 0, null: false
    t.jsonb "questions_data", default: []
    t.jsonb "responses_data", default: []
    t.jsonb "feedback_data", default: {}
    t.float "overall_score"
    t.integer "total_questions", default: 5
    t.integer "answered_questions", default: 0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_mock_interviews_on_status"
    t.index ["user_id", "created_at"], name: "index_mock_interviews_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_mock_interviews_on_user_id"
  end

  create_table "negotiation_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "current_offer", precision: 12, scale: 2
    t.decimal "expected_salary", precision: 12, scale: 2
    t.string "company_name"
    t.string "offer_role"
    t.jsonb "benefits_data", default: {}
    t.jsonb "strategy_data", default: {}
    t.jsonb "talking_points", default: []
    t.jsonb "counter_offer_data", default: {}
    t.float "negotiation_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_negotiation_sessions_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_negotiation_sessions_on_user_id"
  end

  create_table "offer_analyses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name"
    t.string "offer_role"
    t.decimal "base_salary", precision: 12, scale: 2
    t.decimal "total_ctc", precision: 12, scale: 2
    t.jsonb "components_data", default: {}
    t.jsonb "analysis_data", default: {}
    t.jsonb "red_flags", default: []
    t.jsonb "green_flags", default: []
    t.float "offer_score"
    t.string "verdict"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_offer_analyses_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_offer_analyses_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "career_report_id", null: false
    t.string "razorpay_order_id"
    t.string "razorpay_payment_id"
    t.decimal "amount"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["career_report_id"], name: "index_payments_on_career_report_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "peer_benchmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "salary_percentile"
    t.float "skill_percentile"
    t.float "interview_percentile"
    t.integer "peer_count"
    t.jsonb "peer_distribution", default: {}
    t.jsonb "comparison_data", default: {}
    t.jsonb "ranking_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_peer_benchmarks_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_peer_benchmarks_on_user_id"
  end

  create_table "prep_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "icon_name"
    t.string "color_class"
    t.integer "position", default: 0
    t.string "difficulty_level"
    t.integer "estimated_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_prep_categories_on_position"
    t.index ["slug"], name: "index_prep_categories_on_slug", unique: true
  end

  create_table "prep_lessons", force: :cascade do |t|
    t.bigint "prep_category_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "topic"
    t.integer "duration_minutes"
    t.string "difficulty_label"
    t.integer "position", default: 0
    t.jsonb "content_data", default: {}
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_prep_lessons_on_position"
    t.index ["prep_category_id"], name: "index_prep_lessons_on_prep_category_id"
  end

  create_table "readiness_scores", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "overall_score", default: 0.0
    t.jsonb "category_scores", default: {}
    t.float "mock_interview_score", default: 0.0
    t.float "lesson_score", default: 0.0
    t.float "streak_score", default: 0.0
    t.datetime "calculated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "calculated_at"], name: "index_readiness_scores_on_user_id_and_calculated_at"
    t.index ["user_id"], name: "index_readiness_scores_on_user_id"
  end

  create_table "referral_rewards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "referred_user_id", null: false
    t.string "reward_type", null: false
    t.integer "reward_days", default: 0
    t.string "status", default: "pending"
    t.datetime "credited_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referred_user_id"], name: "index_referral_rewards_on_referred_user_id"
    t.index ["status"], name: "index_referral_rewards_on_status"
    t.index ["user_id", "referred_user_id"], name: "idx_referral_rewards_unique", unique: true
    t.index ["user_id"], name: "index_referral_rewards_on_user_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "file_url"
    t.jsonb "parsed_data"
    t.integer "parsing_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "ats_score"
    t.jsonb "ats_data", default: {}
    t.index ["user_id"], name: "index_resumes_on_user_id"
  end

  create_table "role_skill_mappings", force: :cascade do |t|
    t.string "role"
    t.bigint "skill_id", null: false
    t.float "importance_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_role_skill_mappings_on_skill_id"
  end

  create_table "salary_benchmarks", force: :cascade do |t|
    t.string "role"
    t.string "city"
    t.string "experience_range"
    t.decimal "min_salary"
    t.decimal "median_salary"
    t.decimal "max_salary"
    t.string "company_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salary_submissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "role", null: false
    t.string "city", null: false
    t.integer "experience_years", null: false
    t.decimal "base_salary", precision: 12, scale: 2, null: false
    t.decimal "total_ctc", precision: 12, scale: 2
    t.string "company_name"
    t.string "company_type"
    t.jsonb "components_data", default: {}
    t.boolean "verified", default: false
    t.boolean "anonymous", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_salary_submissions_on_created_at"
    t.index ["role", "city", "experience_years"], name: "idx_salary_submissions_lookup"
    t.index ["user_id"], name: "index_salary_submissions_on_user_id"
    t.index ["verified"], name: "index_salary_submissions_on_verified"
  end

  create_table "skill_trends", force: :cascade do |t|
    t.string "skill_name", null: false
    t.string "role"
    t.string "city"
    t.integer "demand_score", default: 0
    t.float "salary_premium_pct", default: 0.0
    t.string "trend_direction", default: "stable"
    t.integer "job_postings_count", default: 0
    t.jsonb "monthly_data", default: []
    t.string "period", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demand_score"], name: "index_skill_trends_on_demand_score"
    t.index ["skill_name", "role", "period"], name: "idx_skill_trends_unique", unique: true
    t.index ["trend_direction"], name: "index_skill_trends_on_trend_direction"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.float "demand_index"
    t.float "salary_uplift_index"
    t.float "learning_difficulty_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "razorpay_subscription_id", null: false
    t.string "razorpay_plan_id", null: false
    t.string "plan_name", null: false
    t.integer "status", default: 0, null: false
    t.integer "amount"
    t.string "short_url"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "cancelled_at"
    t.integer "total_count"
    t.integer "paid_count", default: 0
    t.string "razorpay_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["razorpay_subscription_id"], name: "index_subscriptions_on_razorpay_subscription_id", unique: true
    t.index ["status"], name: "index_subscriptions_on_status"
    t.index ["user_id"], name: "index_subscriptions_on_user_id", unique: true
  end

  create_table "user_streaks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "current_streak", default: 0, null: false
    t.integer "longest_streak", default: 0, null: false
    t.date "last_completed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_streaks_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "full_name"
    t.string "google_uid"
    t.string "profile_picture_url"
    t.string "provider"
    t.string "role"
    t.string "city"
    t.integer "experience_years"
    t.decimal "current_salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "referral_code"
    t.bigint "referred_by_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["referred_by_id"], name: "index_users_on_referred_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "career_reports", "users"
  add_foreign_key "challenge_attempts", "daily_challenges"
  add_foreign_key "challenge_attempts", "users"
  add_foreign_key "coach_conversations", "users"
  add_foreign_key "coach_messages", "coach_conversations"
  add_foreign_key "company_analytics_snapshots", "companies"
  add_foreign_key "company_members", "companies"
  add_foreign_key "company_members", "users"
  add_foreign_key "interview_debriefs", "users"
  add_foreign_key "interview_experiences", "users"
  add_foreign_key "job_recommendations", "job_listings"
  add_foreign_key "job_recommendations", "users"
  add_foreign_key "lesson_progresses", "prep_lessons"
  add_foreign_key "lesson_progresses", "users"
  add_foreign_key "linkedin_profiles", "users"
  add_foreign_key "mock_interviews", "users"
  add_foreign_key "negotiation_sessions", "users"
  add_foreign_key "offer_analyses", "users"
  add_foreign_key "payments", "career_reports"
  add_foreign_key "payments", "users"
  add_foreign_key "peer_benchmarks", "users"
  add_foreign_key "prep_lessons", "prep_categories"
  add_foreign_key "readiness_scores", "users"
  add_foreign_key "referral_rewards", "users"
  add_foreign_key "referral_rewards", "users", column: "referred_user_id"
  add_foreign_key "resumes", "users"
  add_foreign_key "role_skill_mappings", "skills"
  add_foreign_key "salary_submissions", "users"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "user_streaks", "users"
end
