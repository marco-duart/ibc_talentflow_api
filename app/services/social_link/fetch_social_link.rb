class SocialLink::FetchSocialLink
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @social_link_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    @social_link_id ? fetch_by_id : fetch_all
  end

  private

  def valid_params?
    @user_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def fetch_all
    User.find(@user_id).candidate.social_links
  end

  def fetch_by_id
    social_link = User.find(@user_id).candidate.social_links.find(@social_link_id)
    raise StandardError, 'Error! ' unless social_link

    social_link
  end
end
