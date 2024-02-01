class ApplicationStatus::DeleteApplicationStatus
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @application_id = params['id']
  end

  def run
    return unless valid_params?
    return unless application_exists?

    delete_application
  end

  private

  def valid_params?
    @user_id.present? && @application_id.present?
  end

  def application_exists?
    application = User.find(@user_id).candidate.applications.where(id: @application_id)
    application.exists?
  end

  def delete_application
    application = ApplicationStatus.find(@application_id)
    return unless application

    application.destroy
  end
end
