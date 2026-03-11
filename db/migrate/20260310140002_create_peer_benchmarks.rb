class CreatePeerBenchmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :peer_benchmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.float :salary_percentile
      t.float :skill_percentile
      t.float :interview_percentile
      t.integer :peer_count
      t.jsonb :peer_distribution, default: {}
      t.jsonb :comparison_data, default: {}
      t.jsonb :ranking_data, default: {}
      t.timestamps
    end

    add_index :peer_benchmarks, [:user_id, :created_at]
  end
end
