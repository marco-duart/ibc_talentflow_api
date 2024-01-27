class Interview < ApplicationRecord
  belongs_to :hiring_process
  belongs_to :application_status
  belongs_to :recruiter
end
