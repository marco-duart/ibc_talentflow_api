class User < ApplicationRecord
  include Discard::Model

  has_one :candidate
  has_one :recruiter

  validates :cpf, presence: true, cpf: true, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true
  validates :password_digest, presence: true

  before_save :encrypt_password

  has_secure_password

  private

  def encrypt_password
    self.password_digest = BCrypt::Password.create(password_digest) if password_digest.present?
  end
end
