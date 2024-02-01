class ProfessionalLink::DeleteProfessionalLink
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @professional_link_id = params['id']
  end

  def run
    return unless valid_params?
    return unless professional_link_exists?

    delete_professional_link
  end

  private

  def valid_params?
    @user_id.present? && @professional_link_id.present?
  end

  def professional_link_exists?
    professional_link = User.find(@user_id).candidate.professional_links.where(id: @professional_link_id)
    professional_link.exists?
  end

  def delete_professional_link
    professional_link = ProfessionalLink.find(@professional_link_id)
    return unless professional_link

    professional_link.destroy
  end
end
