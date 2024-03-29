class ProfessionalLink::UpdateProfessionalLink
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @professional_link_id = params['id']
    @professional_link_attributes = {
      title: params['title'],
      link: params['link']
    }
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    update_professional_link
  end

  private

  def valid_params?
    @user_id.present? && @professional_link_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def update_professional_link
    professional_link = ProfessionalLink.find(@professional_link_id)
    raise StandardError, 'Error! Professional link not found.' unless professional_link

    professional_link.update(@professional_link_attributes.compact)
  end
end
