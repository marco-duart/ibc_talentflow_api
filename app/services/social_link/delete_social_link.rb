class SocialLink::DeleteSocialLink
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @social_link_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    return unless social_link_exists?

    delete_social_link
  end

  private

  def valid_params?
    @user_id.present? && @social_link_id.present?
  end

  def social_link_exists?
    social_link = User.find(@user_id).candidate.social_links.find_by(id: @social_link_id)
    social_link.exists?
  end

  def delete_social_link
    social_link = SocialLink.find(@social_link_id)
    return unless social_link

    social_link.destroy
  end
end
