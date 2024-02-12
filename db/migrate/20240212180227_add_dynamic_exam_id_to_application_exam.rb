class AddDynamicExamIdToApplicationExam < ActiveRecord::Migration[7.1]
  def change
    add_reference :application_exams, :dynamic_exam, null: false, foreign_key: true
  end
end
