class CreateApplicationStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :application_statuses do |t|
      t.timestamps
    end
  end
end
