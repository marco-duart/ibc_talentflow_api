class CreateExamResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :exam_responses, &:timestamps
    add_reference :exam_responses, :application_exam, null: false, foreign_key: true
    add_reference :exam_responses, :question_alternative, null: false, foreign_key: true
  end
end
