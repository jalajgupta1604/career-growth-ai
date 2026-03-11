class AddAtsScoreToResumes < ActiveRecord::Migration[8.0]
  def change
    add_column :resumes, :ats_score, :float
    add_column :resumes, :ats_data, :jsonb, default: {}
  end
end
