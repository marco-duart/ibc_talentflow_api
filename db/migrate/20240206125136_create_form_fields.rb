class CreateFormFields < ActiveRecord::Migration[6.1]
  def change
    create_table :form_fields do |t|
      t.text :question
      t.string :response_type

      t.timestamps
    end
    add_reference :form_fields, :dynamic_form, null: false, foreign_key: true
  end
end
