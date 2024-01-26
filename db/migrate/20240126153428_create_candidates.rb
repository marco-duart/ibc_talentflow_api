class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.string :phone_number1
      t.string :phone_number2
      t.boolean :employee
      t.string :resume
      t.string :portfolio
      t.text :skills

      t.timestamps
    end
  end
end
