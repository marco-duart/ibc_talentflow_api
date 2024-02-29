class ApplicationStatus::UpdateApplicationStatus
  NEGATIVE_STATUS = ['DESISTIU', 'REPROVADO', 'SEM INTERESSE']
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

  def hiring_process_stage_exists?
    HiringProcessStage.exists?(@application_attributes['hiring_process_stage_id'])
  end

  def build_mailer_params
    stage = HiringProcessStage.find(@application_attributes['hiring_process_stage_id']).title
    candidate = ApplicationStatus.find(@application_id).candidate

    {
      stage:,
      name: candidate.name,
      email: candidate.email,
      gender: candidate.gender
    }
  end

  def update_application
    application = ApplicationStatus.find(@application_id)
    return 'Error' unless application

    application.update(@application_attributes.compact)
    mailer_params = build_mailer_params
    if application.hiring_process_stage.in?(NEGATIVE_STATUS)
      UserMailer.positive_update_process_email(mailer_params).deliver_now
    else
      UserMailer.negative_update_process_email(mailer_params).deliver_now
    end
    { message: 'Sucessfull to change candidate stage!', error: false }
  end
end
