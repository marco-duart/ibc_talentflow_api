class CreateQuestionAlternatives < ActiveRecord::Migration[7.1]
  def change
    create_table :question_alternatives do |t|
      t.boolean :correct
      t.text :text

      t.timestamps
    end
    add_reference :question_alternatives, :exam_question, null: false, foreign_key: true
  end
end
