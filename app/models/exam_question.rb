class ExamQuestion < ApplicationRecord
  belongs_to :dynamic_exam
  has_many :alternatives, class_name: 'QuestionAlternative', dependent: :destroy
end
