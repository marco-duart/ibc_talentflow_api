class CreateJobPostings < ActiveRecord::Migration[6.1]
  def change
    create_table :job_postings do |t|
      t.string :title
      t.string :description
      t.text :requirements
      t.string :job_location
      t.string :regime
      t.string :modality
      t.string :salary
      t.string :work_schedule
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
