class CreateCandidateKnowledges < ActiveRecord::Migration[7.1]
  def change
    create_table :candidate_knowledges do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :knowledge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
