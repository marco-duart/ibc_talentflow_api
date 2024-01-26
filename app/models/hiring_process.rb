class HiringProcess < ApplicationRecord
    belongs_to :company
    has_many :feedback
    has_many :application_status
    has_many :interview
    has_many :exam
end
