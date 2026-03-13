class AddSearchIndexes < ActiveRecord::Migration[8.0]
  def change
    enable_extension 'pg_trgm' unless extension_enabled?('pg_trgm')

    add_index :discussion_threads, :title, using: :gin, opclass: :gin_trgm_ops, name: 'idx_discussion_threads_title_trgm'
    add_index :community_posts, :content, using: :gin, opclass: :gin_trgm_ops, name: 'idx_community_posts_content_trgm'
    add_index :company_reviews, :company_name, using: :gin, opclass: :gin_trgm_ops, name: 'idx_company_reviews_company_trgm'
    add_index :job_postings, :title, using: :gin, opclass: :gin_trgm_ops, name: 'idx_job_postings_title_trgm'
    add_index :interview_experiences, :company_name, using: :gin, opclass: :gin_trgm_ops, name: 'idx_interview_exp_company_trgm'
  end
end
