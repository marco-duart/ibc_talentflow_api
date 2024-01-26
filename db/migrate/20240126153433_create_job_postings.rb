class CreateJobPostings < ActiveRecord::Migration[6.1]
  def change
    create_table :job_postings do |t|
      t.string :title
      t.string :description
      t.text :requirements
      t.string :job_location
      t.string :salary
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
