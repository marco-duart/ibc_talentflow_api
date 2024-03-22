# rubocop:disable Metrics

class UserRecruiter::FetchRecruiter
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['user_id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    fetch_by_id
  end

  private

  def valid_params?
    @user_id.present?
  end

  def recruiter_exists?
    user = User.find(@user_id)
    user.recruiter.present?
  end

  def build_response(user, recruiter, photo_url)
    {
      id: user.id,
      recruiter_id: recruiter.id,
      name: user.name,
      email: user.email,
      position: recruiter.position,
      photo_url:,
      created_at: recruiter.created_at,
      updated_at: recruiter.updated_at
    }
  end

  def fetch_by_id
    user = User.find(@user_id)
    recruiter = user.recruiter
    photo_url = url_for(user.photo) if user.photo.attached?
    build_response(user, recruiter, photo_url)
  end
end
