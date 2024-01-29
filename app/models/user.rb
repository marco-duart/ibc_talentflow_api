class User < ApplicationRecord
  has_secure_password

  has_one :candidate
  has_one :recruiter

  before_save :encrypt_password

  validates :cpf, presence: true, cpf: true, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true

  private

  def encrypt_password
    self.password = BCrypt::Password.create(password) if password.present?
  end
end
