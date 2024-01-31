class JobPosting < ApplicationRecord
  belongs_to :company
  has_many :hiring_processes, dependent: :destroy
end
