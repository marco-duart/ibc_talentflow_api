class AddHiringProcessIdToApplicationStatus < ActiveRecord::Migration[6.1]
  def change
    add_reference :application_statuses, :hiring_process, null: false, foreign_key: true
  end
end
