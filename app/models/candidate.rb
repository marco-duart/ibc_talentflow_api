class Candidate < ApplicationRecord
    belongs_to :user
    has_many :application_status
end
