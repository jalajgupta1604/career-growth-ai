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

ActiveRecord::Schema[8.0].define(version: 2026_03_16_140001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"

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

  create_table "analytics_events", force: :cascade do |t|
    t.bigint "user_id"
    t.string "event_type", null: false
    t.string "resource_type"
    t.integer "resource_id"
    t.jsonb "properties", default: {}
    t.string "session_id"
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_analytics_events_on_created_at"
    t.index ["event_type"], name: "index_analytics_events_on_event_type"
    t.index ["resource_type", "resource_id"], name: "index_analytics_events_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_analytics_events_on_user_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "key", null: false
    t.string "name", null: false
    t.integer "calls_count", default: 0, null: false
    t.integer "rate_limit", default: 100, null: false
    t.string "tier", default: "free", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_api_keys_on_key", unique: true
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "audit_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "action"
    t.string "resource_type"
    t.integer "resource_id"
    t.jsonb "metadata"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "candidate_reveals", force: :cascade do |t|
    t.bigint "employer_profile_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_profile_id", "user_id"], name: "index_candidate_reveals_on_employer_profile_id_and_user_id", unique: true
    t.index ["employer_profile_id"], name: "index_candidate_reveals_on_employer_profile_id"
    t.index ["user_id"], name: "index_candidate_reveals_on_user_id"
  end

  create_table "candidate_searches", force: :cascade do |t|
    t.bigint "employer_profile_id", null: false
    t.jsonb "filters", default: {}
    t.jsonb "results", default: []
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_profile_id"], name: "index_candidate_searches_on_employer_profile_id"
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

  create_table "career_simulations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "scenario_data", default: {}, null: false
    t.jsonb "result_data", default: {}, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_career_simulations_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_career_simulations_on_user_id"
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

  create_table "cms_contents", force: :cascade do |t|
    t.string "content_type", null: false
    t.string "title", null: false
    t.string "slug"
    t.text "body"
    t.jsonb "metadata", default: {}
    t.string "status", default: "draft"
    t.bigint "author_id", null: false
    t.datetime "published_at"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_cms_contents_on_author_id"
    t.index ["content_type", "status"], name: "index_cms_contents_on_content_type_and_status"
    t.index ["slug"], name: "index_cms_contents_on_slug", unique: true
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

  create_table "code_submissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "language", default: "python", null: false
    t.text "code", null: false
    t.jsonb "problem_data", default: {}, null: false
    t.jsonb "test_results", default: {}, null: false
    t.jsonb "ai_feedback", default: {}, null: false
    t.integer "score", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_code_submissions_on_user_id"
  end

  create_table "community_posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "post_type", default: "milestone", null: false
    t.string "title"
    t.text "content", null: false
    t.boolean "anonymous", default: false
    t.integer "likes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "idx_community_posts_content_trgm", opclass: :gin_trgm_ops, using: :gin
    t.index ["created_at"], name: "index_community_posts_on_created_at"
    t.index ["post_type"], name: "index_community_posts_on_post_type"
    t.index ["user_id"], name: "index_community_posts_on_user_id"
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
    t.bigint "department_id"
    t.string "title"
    t.bigint "manager_id"
    t.string "employment_status", default: "active"
    t.date "start_date"
    t.date "end_date"
    t.index ["company_id", "user_id"], name: "index_company_members_on_company_id_and_user_id", unique: true
    t.index ["company_id"], name: "index_company_members_on_company_id"
    t.index ["department_id"], name: "index_company_members_on_department_id"
    t.index ["employment_status"], name: "index_company_members_on_employment_status"
    t.index ["manager_id"], name: "index_company_members_on_manager_id"
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

  create_table "company_reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name", null: false
    t.integer "overall_rating", null: false
    t.text "pros"
    t.text "cons"
    t.string "interview_difficulty"
    t.string "salary_range"
    t.string "role_reviewed"
    t.string "employment_status", default: "current"
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_name"], name: "idx_company_reviews_company_trgm", opclass: :gin_trgm_ops, using: :gin
    t.index ["company_name"], name: "index_company_reviews_on_company_name"
    t.index ["user_id"], name: "index_company_reviews_on_user_id"
  end

  create_table "content_flags", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "flaggable_type", null: false
    t.bigint "flaggable_id", null: false
    t.string "reason"
    t.integer "status"
    t.text "notes"
    t.bigint "resolved_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flaggable_type", "flaggable_id"], name: "index_content_flags_on_flaggable"
    t.index ["resolved_by_id"], name: "index_content_flags_on_resolved_by_id"
    t.index ["user_id"], name: "index_content_flags_on_user_id"
  end

  create_table "content_versions", force: :cascade do |t|
    t.bigint "cms_content_id", null: false
    t.bigint "author_id", null: false
    t.integer "version_number", null: false
    t.text "body"
    t.string "title"
    t.text "change_summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_content_versions_on_author_id"
    t.index ["cms_content_id", "version_number"], name: "index_content_versions_on_cms_content_id_and_version_number", unique: true
    t.index ["cms_content_id"], name: "index_content_versions_on_cms_content_id"
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

  create_table "departments", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name", null: false
    t.bigint "head_id"
    t.bigint "parent_department_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "name"], name: "index_departments_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_departments_on_company_id"
    t.index ["head_id"], name: "index_departments_on_head_id"
    t.index ["parent_department_id"], name: "index_departments_on_parent_department_id"
  end

  create_table "discussion_replies", force: :cascade do |t|
    t.bigint "discussion_thread_id", null: false
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_thread_id"], name: "index_discussion_replies_on_discussion_thread_id"
    t.index ["user_id"], name: "index_discussion_replies_on_user_id"
  end

  create_table "discussion_threads", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.string "category", null: false
    t.boolean "pinned", default: false, null: false
    t.integer "replies_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "idx_discussion_threads_title_trgm", opclass: :gin_trgm_ops, using: :gin
    t.index ["user_id"], name: "index_discussion_threads_on_user_id"
  end

  create_table "employer_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name", null: false
    t.string "company_domain"
    t.string "company_size"
    t.string "industry"
    t.string "company_logo_url"
    t.text "company_description"
    t.boolean "verified", default: false
    t.string "verification_token"
    t.datetime "verified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "company_website"
    t.string "headquarters"
    t.integer "candidate_reveal_credits", default: 0
    t.string "billing_plan"
    t.datetime "billing_period_end"
    t.integer "total_hires", default: 0
    t.float "avg_time_to_hire_days"
    t.float "avg_cost_per_hire"
    t.index ["company_domain"], name: "index_employer_profiles_on_company_domain"
    t.index ["slug"], name: "index_employer_profiles_on_slug", unique: true
    t.index ["user_id"], name: "index_employer_profiles_on_user_id"
    t.index ["verification_token"], name: "index_employer_profiles_on_verification_token", unique: true
  end

  create_table "generated_resumes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "target_role", null: false
    t.jsonb "resume_data", default: {}, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_generated_resumes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_generated_resumes_on_user_id"
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
    t.index ["company_name"], name: "idx_interview_exp_company_trgm", opclass: :gin_trgm_ops, using: :gin
    t.index ["created_at"], name: "index_interview_experiences_on_created_at"
    t.index ["difficulty"], name: "index_interview_experiences_on_difficulty"
    t.index ["outcome"], name: "index_interview_experiences_on_outcome"
    t.index ["user_id"], name: "index_interview_experiences_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "payment_id"
    t.string "invoice_number", null: false
    t.integer "amount", null: false
    t.integer "tax_amount", default: 0
    t.integer "total_amount", null: false
    t.string "gstin"
    t.string "status", default: "generated"
    t.jsonb "line_items", default: []
    t.jsonb "billing_address", default: {}
    t.datetime "issued_at"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_number"], name: "index_invoices_on_invoice_number", unique: true
    t.index ["payment_id"], name: "index_invoices_on_payment_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_posting_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "applied_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pipeline_stage", default: "applied"
    t.text "employer_notes"
    t.index ["job_posting_id"], name: "index_job_applications_on_job_posting_id"
    t.index ["pipeline_stage"], name: "index_job_applications_on_pipeline_stage"
    t.index ["status"], name: "index_job_applications_on_status"
    t.index ["user_id", "job_posting_id"], name: "index_job_applications_on_user_id_and_job_posting_id", unique: true
    t.index ["user_id"], name: "index_job_applications_on_user_id"
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

  create_table "job_postings", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "title", null: false
    t.text "description"
    t.string "location"
    t.string "job_type", default: "full_time"
    t.integer "min_salary"
    t.integer "max_salary"
    t.jsonb "required_skills", default: []
    t.string "experience_range"
    t.integer "status", default: 0, null: false
    t.bigint "posted_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employer_profile_id"
    t.string "application_email"
    t.string "application_url"
    t.boolean "featured", default: false
    t.datetime "expires_at"
    t.index ["employer_profile_id"], name: "index_job_postings_on_employer_profile_id"
    t.index ["posted_by_id"], name: "index_job_postings_on_posted_by_id"
    t.index ["status"], name: "index_job_postings_on_status"
    t.index ["title"], name: "idx_job_postings_title_trgm", opclass: :gin_trgm_ops, using: :gin
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

  create_table "mentor_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "expertise", default: [], null: false
    t.boolean "available", default: true, null: false
    t.text "bio"
    t.integer "max_mentees", default: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mentor_profiles_on_user_id"
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
    t.string "company_style"
    t.jsonb "follow_up_data", default: {}
    t.boolean "simulator_mode", default: false
    t.jsonb "scorecard_data", default: {}
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

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "body"
    t.string "category"
    t.datetime "read_at"
    t.string "action_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
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
    t.string "razorpay_refund_id"
    t.datetime "refunded_at"
    t.text "refund_reason"
    t.bigint "refunded_by_id"
    t.index ["career_report_id"], name: "index_payments_on_career_report_id"
    t.index ["refunded_by_id"], name: "index_payments_on_refunded_by_id"
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

  create_table "peer_practice_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "partner_id"
    t.string "session_type", default: "mock_interview", null: false
    t.integer "status", default: 0, null: false
    t.string "target_company"
    t.string "target_role"
    t.datetime "scheduled_at"
    t.jsonb "feedback_data", default: {}
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_peer_practice_sessions_on_partner_id"
    t.index ["user_id"], name: "index_peer_practice_sessions_on_user_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "community_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_post_id"], name: "index_post_likes_on_community_post_id"
    t.index ["user_id", "community_post_id"], name: "index_post_likes_on_user_id_and_community_post_id", unique: true
    t.index ["user_id"], name: "index_post_likes_on_user_id"
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

  create_table "push_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "endpoint", null: false
    t.string "p256dh_key"
    t.string "auth_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint"], name: "index_push_subscriptions_on_endpoint", unique: true
    t.index ["user_id"], name: "index_push_subscriptions_on_user_id"
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

  create_table "revision_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "source_type", null: false
    t.integer "source_id"
    t.string "topic", null: false
    t.string "difficulty", default: "medium", null: false
    t.float "easiness_factor", default: 2.5, null: false
    t.integer "interval", default: 1, null: false
    t.integer "repetitions", default: 0, null: false
    t.datetime "next_review_at", null: false
    t.datetime "last_reviewed_at"
    t.integer "correct_streak", default: 0, null: false
    t.integer "total_attempts", default: 0, null: false
    t.integer "correct_attempts", default: 0, null: false
    t.jsonb "question_data", default: {}, null: false
    t.jsonb "answer_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "next_review_at"], name: "index_revision_items_on_user_id_and_next_review_at"
    t.index ["user_id", "source_type", "source_id"], name: "index_revision_items_on_user_id_and_source_type_and_source_id", unique: true
    t.index ["user_id", "topic"], name: "index_revision_items_on_user_id_and_topic"
    t.index ["user_id"], name: "index_revision_items_on_user_id"
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

  create_table "salary_forecasts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "current_salary", null: false
    t.jsonb "projected_salaries", default: {}, null: false
    t.jsonb "skill_plan", default: {}, null: false
    t.jsonb "market_factors", default: {}, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_salary_forecasts_on_user_id"
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

  create_table "scheduled_challenges", force: :cascade do |t|
    t.bigint "cms_content_id"
    t.string "title", null: false
    t.text "question"
    t.jsonb "options", default: []
    t.string "correct_answer"
    t.text "explanation"
    t.string "difficulty", default: "medium"
    t.string "topic"
    t.date "scheduled_for"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cms_content_id"], name: "index_scheduled_challenges_on_cms_content_id"
    t.index ["scheduled_for"], name: "index_scheduled_challenges_on_scheduled_for", unique: true
  end

  create_table "search_queries", force: :cascade do |t|
    t.bigint "user_id"
    t.string "query", null: false
    t.integer "results_count", default: 0
    t.string "result_type_clicked"
    t.integer "result_id_clicked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_search_queries_on_created_at"
    t.index ["query"], name: "index_search_queries_on_query"
    t.index ["user_id"], name: "index_search_queries_on_user_id"
  end

  create_table "skill_badges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "badge_type", null: false
    t.string "skill_name"
    t.string "level", default: "bronze"
    t.jsonb "criteria_met", default: {}
    t.datetime "earned_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "badge_type", "skill_name"], name: "index_skill_badges_on_user_id_and_badge_type_and_skill_name", unique: true
    t.index ["user_id"], name: "index_skill_badges_on_user_id"
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

  create_table "study_group_memberships", force: :cascade do |t|
    t.bigint "study_group_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_group_id", "user_id"], name: "index_study_group_memberships_on_study_group_id_and_user_id", unique: true
    t.index ["study_group_id"], name: "index_study_group_memberships_on_study_group_id"
    t.index ["user_id"], name: "index_study_group_memberships_on_user_id"
  end

  create_table "study_groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "target_company"
    t.string "target_role"
    t.integer "max_members", default: 10
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_study_groups_on_creator_id"
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
    t.integer "dunning_attempts", default: 0
    t.datetime "last_dunning_at"
    t.string "dunning_state"
    t.string "previous_plan_name"
    t.datetime "plan_change_scheduled_at"
    t.string "pending_plan_name"
    t.index ["dunning_state"], name: "index_subscriptions_on_dunning_state"
    t.index ["razorpay_subscription_id"], name: "index_subscriptions_on_razorpay_subscription_id", unique: true
    t.index ["status"], name: "index_subscriptions_on_status"
    t.index ["user_id"], name: "index_subscriptions_on_user_id", unique: true
  end

  create_table "user_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_token", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.string "device_type"
    t.datetime "last_active_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_token"], name: "index_user_sessions_on_session_token", unique: true
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
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
    t.boolean "admin", default: false, null: false
    t.string "admin_role", default: "none", null: false
    t.datetime "data_export_requested_at"
    t.datetime "data_exported_at"
    t.datetime "deletion_requested_at"
    t.datetime "deletion_scheduled_at"
    t.string "user_type", default: "job_seeker"
    t.float "engagement_score", default: 0.0
    t.jsonb "dashboard_layout", default: {}
    t.jsonb "notification_preferences", default: {}
    t.datetime "last_active_at"
    t.jsonb "career_goals", default: []
    t.string "onboarding_path"
    t.jsonb "privacy_settings", default: {}
    t.string "health_score_risk"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["referred_by_id"], name: "index_users_on_referred_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "webhook_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "url", null: false
    t.string "secret"
    t.jsonb "events", default: []
    t.boolean "active", default: true
    t.datetime "last_triggered_at"
    t.integer "failure_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_webhook_subscriptions_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "analytics_events", "users"
  add_foreign_key "api_keys", "users"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "candidate_reveals", "employer_profiles"
  add_foreign_key "candidate_reveals", "users"
  add_foreign_key "candidate_searches", "employer_profiles"
  add_foreign_key "career_reports", "users"
  add_foreign_key "career_simulations", "users"
  add_foreign_key "challenge_attempts", "daily_challenges"
  add_foreign_key "challenge_attempts", "users"
  add_foreign_key "cms_contents", "users", column: "author_id"
  add_foreign_key "coach_conversations", "users"
  add_foreign_key "coach_messages", "coach_conversations"
  add_foreign_key "code_submissions", "users"
  add_foreign_key "community_posts", "users"
  add_foreign_key "company_analytics_snapshots", "companies"
  add_foreign_key "company_members", "companies"
  add_foreign_key "company_members", "company_members", column: "manager_id"
  add_foreign_key "company_members", "departments"
  add_foreign_key "company_members", "users"
  add_foreign_key "company_reviews", "users"
  add_foreign_key "content_flags", "users"
  add_foreign_key "content_flags", "users", column: "resolved_by_id"
  add_foreign_key "content_versions", "cms_contents"
  add_foreign_key "content_versions", "users", column: "author_id"
  add_foreign_key "departments", "companies"
  add_foreign_key "departments", "departments", column: "parent_department_id"
  add_foreign_key "departments", "users", column: "head_id"
  add_foreign_key "discussion_replies", "discussion_threads"
  add_foreign_key "discussion_replies", "users"
  add_foreign_key "discussion_threads", "users"
  add_foreign_key "employer_profiles", "users"
  add_foreign_key "generated_resumes", "users"
  add_foreign_key "interview_debriefs", "users"
  add_foreign_key "interview_experiences", "users"
  add_foreign_key "invoices", "payments"
  add_foreign_key "invoices", "users"
  add_foreign_key "job_applications", "job_postings"
  add_foreign_key "job_applications", "users"
  add_foreign_key "job_postings", "employer_profiles"
  add_foreign_key "job_postings", "users", column: "posted_by_id"
  add_foreign_key "job_recommendations", "job_listings"
  add_foreign_key "job_recommendations", "users"
  add_foreign_key "lesson_progresses", "prep_lessons"
  add_foreign_key "lesson_progresses", "users"
  add_foreign_key "linkedin_profiles", "users"
  add_foreign_key "mentor_profiles", "users"
  add_foreign_key "mock_interviews", "users"
  add_foreign_key "negotiation_sessions", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "offer_analyses", "users"
  add_foreign_key "payments", "career_reports"
  add_foreign_key "payments", "users"
  add_foreign_key "payments", "users", column: "refunded_by_id"
  add_foreign_key "peer_benchmarks", "users"
  add_foreign_key "peer_practice_sessions", "users"
  add_foreign_key "peer_practice_sessions", "users", column: "partner_id"
  add_foreign_key "post_likes", "community_posts"
  add_foreign_key "post_likes", "users"
  add_foreign_key "prep_lessons", "prep_categories"
  add_foreign_key "push_subscriptions", "users"
  add_foreign_key "readiness_scores", "users"
  add_foreign_key "referral_rewards", "users"
  add_foreign_key "referral_rewards", "users", column: "referred_user_id"
  add_foreign_key "resumes", "users"
  add_foreign_key "revision_items", "users"
  add_foreign_key "role_skill_mappings", "skills"
  add_foreign_key "salary_forecasts", "users"
  add_foreign_key "salary_submissions", "users"
  add_foreign_key "scheduled_challenges", "cms_contents"
  add_foreign_key "search_queries", "users"
  add_foreign_key "skill_badges", "users"
  add_foreign_key "study_group_memberships", "study_groups"
  add_foreign_key "study_group_memberships", "users"
  add_foreign_key "study_groups", "users", column: "creator_id"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "user_sessions", "users"
  add_foreign_key "user_streaks", "users"
  add_foreign_key "webhook_subscriptions", "users"
end
