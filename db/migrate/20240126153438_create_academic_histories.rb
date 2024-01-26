class CreateAcademicHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :academic_histories do |t|
      t.string :title
      t.string :institution
      t.string :degree
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
