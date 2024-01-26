class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :cnpj
      t.string :sector
      t.integer :company_size
      t.string :company_location

      t.timestamps
    end
  end
end
