class Question < ApplicationRecord
    belongs_to :exam
    has_many :answer
end
