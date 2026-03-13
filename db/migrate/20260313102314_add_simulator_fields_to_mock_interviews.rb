class AddSimulatorFieldsToMockInterviews < ActiveRecord::Migration[8.0]
  def change
    add_column :mock_interviews, :company_style, :string
    add_column :mock_interviews, :follow_up_data, :jsonb, default: {}
    add_column :mock_interviews, :simulator_mode, :boolean, default: false
    add_column :mock_interviews, :scorecard_data, :jsonb, default: {}
  end
end
