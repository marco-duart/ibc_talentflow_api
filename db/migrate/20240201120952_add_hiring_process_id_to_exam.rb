class AddHiringProcessIdToExam < ActiveRecord::Migration[6.1]
  def change
    add_reference :exams, :hiring_process, null: false, foreign_key: true
  end
end
