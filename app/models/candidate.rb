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

  private

  def user_presence
    errors.add(:base, 'Incorrect route: User required!') unless user.present?
  end
end
