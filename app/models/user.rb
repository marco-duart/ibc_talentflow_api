class User < ApplicationRecord
  # name: string
  # cpf: string
  # email: string
  # password_digest: string
  # role: string
  include Discard::Model
  # Adicionar atributos para confirmação de conta, bloqueio/desbloqueio de senha

  # Active Storage Method for attach files
  has_one_attached :photo
  has_one :candidate
  has_one :recruiter

  validates :cpf, presence: true, cpf: true, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true
  validates :password_digest, presence: true

  # BCrypt method for encrypt password
  has_secure_password
end
