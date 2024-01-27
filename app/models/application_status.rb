class ApplicationStatus < ApplicationRecord
  belongs_to :candidate
  belongs_to :hiring_process
  has_many :feedbacks, dependent: :nullify
  has_many :interviews, dependent: :nullify
end
