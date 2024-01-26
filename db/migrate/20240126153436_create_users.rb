class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :cpf
      t.string :email
      t.string :password
      t.string :role
      t.string :photo

      t.timestamps
    end
  end
end
