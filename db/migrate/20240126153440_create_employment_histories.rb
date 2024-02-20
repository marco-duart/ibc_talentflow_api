class CreateEmploymentHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :employment_histories do |t|
      t.string :company_name
      t.string :position
      t.string :salary
      t.datetime :start_date
      t.datetime :end_date
      t.string :leaving_reason
      t.text :achievements

      t.timestamps
    end
  end
end
