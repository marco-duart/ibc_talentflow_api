class AddCompanyIdToJobPosting < ActiveRecord::Migration[6.1]
  def change
    add_reference :job_postings, :company, null: false, foreign_key: true
  end
end
