class CreateExamQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :exam_questions do |t|
      t.string :text
      t.string :type

      t.timestamps
    end
    add_reference :exam_questions, :dynamic_exam, null: false, foreign_key: true
  end
end
