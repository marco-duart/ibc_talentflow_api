class AddHiringProcessIdToFeedback < ActiveRecord::Migration[6.1]
  def change
    add_reference :feedbacks, :hiring_process, null: false, foreign_key: true
  end
end
