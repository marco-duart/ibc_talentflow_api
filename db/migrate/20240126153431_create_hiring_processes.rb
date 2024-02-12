class CreateHiringProcesses < ActiveRecord::Migration[6.1]
  def change
    create_table :hiring_processes do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :status

      t.timestamps
    end
  end
end
