class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.string :feedback_title
      t.integer :overall_assessment
      t.string :specific_comment
      t.string :improvements

      t.timestamps
    end
  end
end
