class ApplicationStatus::UpdateApplicationStatus
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @application_id = params['id']
    @application_attributes = {
      title: params['title'],
      institution: params['institution'],
      degree: params['degree'],
      start_date: params['start_date'],
      end_date: params['end_date']
    }
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    update_application
  end

  private

  def valid_params?
    @user_id.present? && @application_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user.candidate.present?
  end

  def update_application
    application = ApplicationStatus.find(@application_id)
    return unless application

    application.update(@application_attributes.compact)
  end
end
