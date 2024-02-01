class AddCandidateIdToEmploymentHistory < ActiveRecord::Migration[6.1]
  def change
    add_reference :employment_histories, :candidate, null: false, foreign_key: true
  end
end
