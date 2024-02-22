class ApplicationStatus::UpdateApplicationStatus
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @application_id = params['application_id']
    @application_attributes = {
      hiring_process_stage_id: params['hiring_process_stage_id']
    }
  end

  def run
    return unless valid_params?
    return unless application_exists?

    update_application
  end

  private

  def valid_params?
    @application_id.present? && @application_attributes.values.any?
  end

  def application_exists?
    ApplicationStatus.exists?(@application_id)
  end

  def update_application
    application = ApplicationStatus.find(@application_id)
    return 'Error' unless application

    application.update(@application_attributes.compact)
    application
  end
end
