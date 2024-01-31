class AddRecruiterIdToHiringProcess < ActiveRecord::Migration[6.1]
  def change
    add_reference :hiring_processes, :recruiter, null: false, foreign_key: true
  end
end
