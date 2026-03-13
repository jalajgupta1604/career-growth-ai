class CreateCandidateSearches < ActiveRecord::Migration[8.0]
  def change
    create_table :candidate_searches do |t|
      t.references :employer_profile, null: false, foreign_key: true
      t.jsonb :filters, default: {}
      t.jsonb :results, default: []
      t.string :name

      t.timestamps
    end
  end
end
