class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.string :phone_number1
      t.string :phone_number2
      t.boolean :employee
      t.string :resume
      t.string :birthplace
      t.string :gender
      t.date :birthdate
      t.string :marital_status
      t.string :address_neighborhood
      t.string :address_city
      t.string :mother_name
      t.string :spouse_name
      t.integer :number_of_children
      t.string :residence_status
      t.string :possessions
      t.boolean :other_incomes
      t.boolean :relatives_in_company
      t.boolean :smoker
      t.boolean :alcohol_consumer
      t.boolean :medication_user
      t.text :first_question
      t.text :second_question
      t.text :third_question
      t.text :fourth_question
      t.text :fifth_question

      t.timestamps
    end
  end
end
