class JobPosting < ApplicationRecord
    belongs_to :company
    has_many :hiring_process, dependent: :nullify
end
