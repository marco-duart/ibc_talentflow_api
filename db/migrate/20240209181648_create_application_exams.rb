class CreateApplicationExams < ActiveRecord::Migration[7.1]
  def change
    create_table :application_exams, &:timestamps
    add_reference :application_exams, :application_status, null: false, foreign_key: true
  end
end
