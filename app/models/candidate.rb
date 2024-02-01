class Candidate < ApplicationRecord
  belongs_to :user
  has_many :applications, class_name: 'ApplicationStatus', dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :academic_histories, dependent: :destroy
  has_many :employment_histories, dependent: :destroy
  has_many :professional_links, dependent: :destroy

  validate :user_presence

  private

  def user_presence
    errors.add(:base, 'Incorrect route: User required!') unless user.present?
  end
end
