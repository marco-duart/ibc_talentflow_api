class ApplicationStatus < ApplicationRecord
  belongs_to :candidate
  belongs_to :hiring_process_stage
  has_one :feedback, dependent: :destroy
  has_many :application_form, dependent: :destroy
  has_many :application_exam, dependent: :destroy
  has_many :interviews, dependent: :destroy
end
