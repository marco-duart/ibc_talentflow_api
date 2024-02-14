class ApplicationStatus < ApplicationRecord
  #status:string screening/form/test/interview/approved/disapproved
  belongs_to :candidate
  belongs_to :hiring_process
  has_one :feedback, dependent: :nullify
  has_many :application_form, dependent: :destroy
  has_many :application_exam, dependent: :destroy
  has_many :interviews, dependent: :nullify
end
