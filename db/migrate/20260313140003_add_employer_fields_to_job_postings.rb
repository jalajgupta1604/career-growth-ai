class AddEmployerFieldsToJobPostings < ActiveRecord::Migration[8.0]
  def change
    add_reference :job_postings, :employer_profile, foreign_key: true, null: true
    add_column :job_postings, :application_email, :string
    add_column :job_postings, :application_url, :string
    add_column :job_postings, :featured, :boolean, default: false
    add_column :job_postings, :expires_at, :datetime
  end
end
