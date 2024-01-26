class CreateApplicationForms < ActiveRecord::Migration[6.1]
  def change
    create_table :application_forms do |t|
      t.integer :general_average

      t.timestamps
    end
  end
end
