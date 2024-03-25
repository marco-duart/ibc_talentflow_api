class SocialLink::UpdateSocialLink
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @social_link_id = params['id']
    @social_link_attributes = {
      title: params['title'],
      link: params['link']
    }
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    update_social_link
  end

  private

  def valid_params?
    @user_id.present? && @social_link_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def update_social_link
    social_link = SocialLink.find(@social_link_id)
    raise StandardError, 'Error! Social link not found.' unless social_link

    social_link.update(@social_link_attributes.compact)
  end
end
