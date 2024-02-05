class CreateApplicationForms < ActiveRecord::Migration[6.1]
  def change
    create_table :application_forms do |t|
      t.text :first
      t.text :second
      t.text :third
      t.text :fourth
      t.text :fifth

      t.timestamps
    end
  end
end
