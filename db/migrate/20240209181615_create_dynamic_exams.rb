class CreateDynamicExams < ActiveRecord::Migration[7.1]
  def change
    create_table :dynamic_exams do |t|
      t.string :title
      t.string :description
      t.string :department

      t.timestamps
    end
  end
end
