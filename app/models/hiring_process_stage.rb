class HiringProcessStage < ApplicationRecord
  # title: string
  belongs_to :hiring_process
  belongs_to :dynamic_exam
  belongs_to :dynamic_form

  has_many :candidate_statuses, class_name: 'ApplicationStatus', dependent: :destroy
  has_many :interviews, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :application_forms, through: :candidate_status
  has_many :application_exams, through: :candidate_status
end
