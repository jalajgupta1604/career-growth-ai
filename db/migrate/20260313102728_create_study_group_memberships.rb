class CreateStudyGroupMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :study_group_memberships do |t|
      t.references :study_group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, default: "member", null: false

      t.timestamps
    end

    add_index :study_group_memberships, [:study_group_id, :user_id], unique: true
  end
end
