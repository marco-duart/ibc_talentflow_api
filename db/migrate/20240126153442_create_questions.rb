class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :text
      t.string :type
      t.string :department

      t.timestamps
    end
  end
end
