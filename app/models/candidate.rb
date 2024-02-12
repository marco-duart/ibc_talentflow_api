class Candidate < ApplicationRecord
  # name:string
  # email:string
  # phone_number1:string
  # phone_number2:string
  # employee:boolean
  # resume:string
  # birthplace:string
  # gender:string
  # birthdate:date
  # marital_status:string
  # address_neighborhood:string
  # address_city:string
  # mother_name:string
  # spouse_name:string
  # number_of_children:integer
  # residence_status:string
  # possessions:string
  # other_incomes:boolean    ///// Alterar para string
  # relatives_in_company:boolean
  # smoker:boolean
  # alcohol_consumer:boolean
  # medication_user:boolean
  # first_question:string
  # second_question:string
  # third_question:string
  # fourth_question:string
  # fifth_question:string
  belongs_to :user
  has_many :applications, class_name: 'ApplicationStatus', dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :academic_histories, dependent: :destroy
  has_many :employment_histories, dependent: :destroy
  has_many :professional_links, dependent: :destroy
  has_many :social_medias, dependent: :destroy

  has_many :candidate_skills
  has_many :skills, through: :candidate_skills

  validate :user_presence

  QUESTIONS = [
    'Descreva suas principais características. O que mais admira em você? O que você considera como sua característica mais marcante.',
    'Existe algo que você gostaria de mudar, alguns pontos de melhoria?',
    'Como você se imagina daqui há 5 anos(vida pessoal, profissional e acadêmica)?',
    'Quem são as pessoas mais importantes para você?',
    'Qual o seu maior sonho?'
  ].freeze

  def question(question_number)
    QUESTIONS[question_number - 1] if question_number.between?(1, 5)
  end

  private

  def user_presence
    errors.add(:base, 'Incorrect route: User required!') unless user.present?
  end
end
