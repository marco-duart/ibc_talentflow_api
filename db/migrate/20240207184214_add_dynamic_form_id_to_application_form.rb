class AddDynamicFormIdToApplicationForm < ActiveRecord::Migration[7.1]
  def change
    add_reference :application_forms, :dynamic_form, null: false, foreign_key: true
  end
end
