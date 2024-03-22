class ApplicationStatus::DeleteApplicationStatus
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @application_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Application not found.' unless application_exists?

    delete_application
  end

  private

  def valid_params?
    @user_id.present? && @application_id.present?
  end

  def application_exists?
    application = User.find(@user_id).candidate.applications.find_by(id: @application_id)
    application.exists?
  end

  def delete_application
    application = ApplicationStatus.find(@application_id)
    raise StandardError, 'Error! Application not found.' unless application

    application.destroy
  end
end
