class CreateCandidateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :candidate_profiles do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
