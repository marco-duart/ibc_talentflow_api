class Recruiter < ApplicationRecord
  # name: string
  # email: string
  # position: string
  belongs_to :user
  has_many :interviews
  has_many :hiring_processes

  validate :user_presence

  private

  def user_presence
    errors.add(:base, 'Incorrect route: User required!') unless user.present?
  end
end
