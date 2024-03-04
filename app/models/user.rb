class User < ApplicationRecord
  # name: string
  # cpf: string
  # email: string
  # password_digest: string
  # role: string
  # confirmed_at: date
  # unconfirmed_email: string // usado para manter o e-mail até confirmar a conta
  # login_attempts: number
  # locked: boolean
  # banned: boolean
  # ban_reason: text
  include Discard::Model

  # Active Storage Method for attach files
  has_one_attached :photo
  has_one :candidate, dependent: :destroy
  has_one :recruiter, dependent: :destroy

  validates :cpf, presence: true, cpf: true, uniqueness: true
  validates :email, uniqueness: { allow_nil: true }
  validates :unconfirmed_email, presence: true, email: true, uniqueness: true
  validates :password_digest, presence: true

  # BCrypt method for encrypt password
  has_secure_password

  scope :valid, -> { where(banned: false).where.not(confirmed_at: nil) }
  scope :invalid, -> { where(confirmed_at: nil) }
  scope :admin, -> { where(role: 'admin') }
  scope :user, -> { where(role: 'user') }

  def confirmed?
    !confirmed_at.nil?
  end
end
