class AddPipelineStageToJobApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :job_applications, :pipeline_stage, :string, default: "applied"
    add_column :job_applications, :employer_notes, :text

    add_index :job_applications, :pipeline_stage
  end
end
