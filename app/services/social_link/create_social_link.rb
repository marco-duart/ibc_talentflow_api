class SocialLink::CreateSocialLink
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @title = params['title']
    @link = params['link']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    create_social_link
  end

  private

  def valid_params?
    @user_id.present? &&
      @title.present? &&
      @link.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def build_params
    {
      title: @title,
      link: @link,
    }
  end

  def create_social_link
    candidate = User.find(@user_id).candidate
    social_link_params = build_params
    social_link = candidate.social_links.build(social_link_params)

    return social_link if social_link.save

    puts "Error! : #{social_link.errors.full_messages}"
  end
end
