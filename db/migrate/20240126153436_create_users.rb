class CreateUsers < ActiveRecord::Migration[6.1]
  def change # rubocop:disable Metrics
    create_table :users do |t|
      t.string :name
      t.string :cpf
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :confirmable_token
      t.datetime :confirmable_token_expires_in
      t.date :confirmed_at, default: nil
      t.string :unconfirmed_email
      t.string :recoverable_token
      t.datetime :recoverable_token_expires_in
      t.integer :login_attempts, default: 0
      t.boolean :locked, default: false
      t.boolean :banned, default: false
      t.text :ban_reason

      t.timestamps
    end
  end
end
