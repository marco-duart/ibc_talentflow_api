class AddCandidateIdToAcademicHistory < ActiveRecord::Migration[6.1]
  def change
    add_reference :academic_histories, :candidate, null: false, foreign_key: true
  end
end
