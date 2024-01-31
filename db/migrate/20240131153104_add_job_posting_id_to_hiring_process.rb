class AddJobPostingIdToHiringProcess < ActiveRecord::Migration[6.1]
  def change
    add_reference :hiring_processes, :job_posting, null: false, foreign_key: true
  end
end
