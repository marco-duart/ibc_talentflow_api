class AddUserIdToCandidate < ActiveRecord::Migration[6.1]
  def change
    add_reference :candidates, :user, null: false, foreign_key: true
  end
end
