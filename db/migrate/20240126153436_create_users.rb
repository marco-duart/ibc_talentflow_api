class CreateUsers < ActiveRecord::Migration[6.1]
  def change # rubocop:disable Metrics
    create_table :users do |t|
      t.string :name
      t.string :cpf
      t.string :email
      t.string :password_digest
      t.string :role
      t.date :confirmed_at, default: nil
      t.string :unconfirmed_email
      t.integer :login_attempts, default: 0
      t.boolean :locked, default: false
      t.boolean :banned, default: false
      t.text :ban_reason
      t.boolean :newsletter, default: true

      t.timestamps
    end
  end
end
