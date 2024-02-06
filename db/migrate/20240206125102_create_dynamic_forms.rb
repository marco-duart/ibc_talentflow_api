class CreateDynamicForms < ActiveRecord::Migration[6.1]
  def change
    create_table :dynamic_forms do |t|
      t.string :title
      t.text :description
      t.string :department

      t.timestamps
    end
  end
end
