class User < ApplicationRecord
  # name: string
  # cpf: string
  # email: string
  # password_digest: string
  # role: string

  # confirmable_token: string
  # confirmable_token_expires_in: datetime
  # confirmed_at: date
  # unconfirmed_email: string // usado para manter o e-mail até confirmar a conta
  # recoverable_token: string
  # recoverable_token_expires_in: datetime
  # login_attempts: number
  # locked: boolean
  # banned: boolean
  # ban_reason: text
  include Discard::Model
  include JWT

  # Active Storage Method for attach files
  has_one_attached :photo
  has_one :candidate
  has_one :recruiter

  validates :cpf, presence: true, cpf: true, uniqueness: true
  validates :email, email: true, uniqueness: true # Não é obrigatório porque é preenchido ao confirmar a conta
  validates :unconfirmed_email, presence: true, email: true, uniqueness: true
  validates :password_digest, presence: true

  # BCrypt method for encrypt password
  has_secure_password

  scope :valid, -> { where(banned: nil).where.not(confirmed_at: nil) }
  scope :invalid, -> { where(confirmed_at: nil) }

  # Actions: 'RESET_PASSWORD' or 'CONFIRM_ACCOUNT'
  def generate_temporary_token(action)
    payload = { user_id: self.id, action:, exp: Time.now.to_i + 1800 }

    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def reset_password(new_password)
    self.password_digest = new_password
    save
  end

  def confirm_account
    self.email = self.unconfirmed_email
    self.unconfirmed_email = nil
    save
  end

  def ban!
    self.candidate?.destroy
    self.banned = true
  end
end
