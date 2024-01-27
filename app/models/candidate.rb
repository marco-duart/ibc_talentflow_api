class Candidate < ApplicationRecord
  belongs_to :user
  has_many :applications, class_name: 'ApplicationStatus', dependent: :nullify

  validate :user_presence

  private

  def user_presence
    errors.add(:base, 'Incorrect route: User required!') unless user.present?
  end
end
