class AddApplicationStatusIdToApplicationForm < ActiveRecord::Migration[6.1]
  def change
    add_reference :application_forms, :application_status, null: false, foreign_key: true
  end
end
