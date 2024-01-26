class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :notification_type
      t.string :recipient
      t.string :message

      t.timestamps
    end
  end
end
