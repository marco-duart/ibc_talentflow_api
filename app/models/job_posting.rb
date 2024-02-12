class JobPosting < ApplicationRecord
  # title: string
  # description: string
  # requirements: text
  # job_location: string
  # regime: string
  # modality: string
  # salary: string
  # work_schedule: string
  # start_date: datetime
  # end_date: datetime
  belongs_to :company
  has_many :hiring_processes, dependent: :destroy
end
