class Recruiter < ApplicationRecord
  belongs_to :user
  has_many :interviews, dependent: :nullify
  has_many :hiring_processes, dependent: :nullify

  validate :user_presence

  private

  def user_presence
    errors.add(:base, 'Incorrect route: User required!') unless user.present?
  end
end
