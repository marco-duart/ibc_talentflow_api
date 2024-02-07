class CreateFormResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :form_responses do |t|
      t.integer :number_value
      t.text :text_value
      t.string :string_value
      t.boolean :boolean_value
      t.date :date_value

      t.timestamps
    end
    add_reference :form_responses, :application_form, null: false, foreign_key: true
    add_reference :form_responses, :form_field, null: false, foreign_key: true
  end
end
