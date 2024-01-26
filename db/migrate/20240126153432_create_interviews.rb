class CreateInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :interviews do |t|
      t.datetime :date_time
      t.string :interview_type
      t.text :resume
      t.string :interview_feedback

      t.timestamps
    end
  end
end
