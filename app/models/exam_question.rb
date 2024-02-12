class ExamQuestion < ApplicationRecord
  # text: string
  # question_type: string
  belongs_to :dynamic_exam
  has_many :alternatives, class_name: 'QuestionAlternative', dependent: :destroy
end
