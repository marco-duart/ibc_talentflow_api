class AddCandidateIdToProfessionalLink < ActiveRecord::Migration[6.1]
  def change
    add_reference :professional_links, :candidate, null: false, foreign_key: true
  end
end
