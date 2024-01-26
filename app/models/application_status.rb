class ApplicationStatus < ApplicationRecord
    belongs_to :candidate
    belongs_to :hiring_process
end
