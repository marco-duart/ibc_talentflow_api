class CreateHiringProcessStages < ActiveRecord::Migration[7.1]
  def change
    create_table :hiring_process_stages do |t|
      t.string :title
      t.references :hiring_process, null: false, foreign_key: true
      t.references :dynamic_form, foreign_key: true
      t.references :dynamic_exam, foreign_key: true

      t.timestamps
    end
  end
end
