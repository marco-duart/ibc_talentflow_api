class ExamResponse < ApplicationRecord
  belongs_to :application_exam
  belongs_to :question_alternative
end
