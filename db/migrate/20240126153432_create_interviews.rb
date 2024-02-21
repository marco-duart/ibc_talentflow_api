class CreateInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :interviews do |t|
      t.datetime :date_time
      t.string :interview_type
      t.string :interviewer
      t.string :interview_method
      t.text :resume

      t.timestamps
    end
  end
end
