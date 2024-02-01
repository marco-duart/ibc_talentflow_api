class AddCandidateIdToApplicationStatus < ActiveRecord::Migration[6.1]
  def change
    add_reference :application_statuses, :candidate, null: false, foreign_key: true
  end
end
