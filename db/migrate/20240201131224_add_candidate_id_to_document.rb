class AddCandidateIdToDocument < ActiveRecord::Migration[6.1]
  def change
    add_reference :documents, :candidate, null: false, foreign_key: true
  end
end
