# rubocop:disable Metrics

class UserCandidate::FetchCandidate
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['user_id']
  end

  def run
    return unless valid_params?

    fetch_by_id
  end

  private

  def valid_params?
    @user_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user.candidate.present?
  end

  def build_response(user, candidate, photo_url, curriculum_url)
    {
      id: user.id,
      candidate_id: candidate.id,
      name: user.name,
      email: user.email,
      photo_url:,
      phone_number1: candidate.phone_number1,
      phone_number2: candidate.phone_number2,
      employee: candidate.employee,
      resume: candidate.resume,
      birthplace: candidate.birthplace,
      gender: candidate.gender,
      birthdate: candidate.birthdate,
      marital_status: candidate.marital_status,
      address_neighborhood: candidate.address_neighborhood,
      address_city: candidate.address_city,
      mother_name: candidate.mother_name,
      spouse_name: candidate.spouse_name,
      number_of_children: candidate.number_of_children,
      residence_status: candidate.residence_status,
      possessions: candidate.possessions,
      other_incomes: candidate.other_incomes,
      relatives_in_company: candidate.relatives_in_company,
      smoker: candidate.smoker,
      alcohol_consumer: candidate.alcohol_consumer,
      medication_user: candidate.medication_user,
      created_at: candidate.created_at,
      updated_at: candidate.updated_at,
      curriculum_url:
    }
  end

  def fetch_by_id
    user = User.find(@user_id)
    candidate = user.candidate
    photo_url = url_for(user.photo) if user.photo.attached?
    curriculum_url = rails_blob_url(candidate.curriculum, disposition: 'attachment') if candidate.curriculum.attached?
    build_response(user, candidate, photo_url, curriculum_url)
  end
end
