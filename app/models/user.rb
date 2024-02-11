class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  include Discard::Model

  has_one :candidate
  has_one :recruiter

  validates :cpf, presence: true, cpf: true, uniqueness: true

  after_database_authentication do
    generate_jwt_token
  end

  def ti?
    role == 'ti'
  end

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

  private

  def generate_jwt_token
    payload = { user_id: id, role: role, exp: Time.now.to_i + 3600 }
    token = JWT.encode(payload, ENV['SECRET_KEY_BASE'], 'HS256')
    update(jwt_token: token)
  end
end
