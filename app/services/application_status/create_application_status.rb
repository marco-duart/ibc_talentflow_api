class ApplicationStatus::CreateApplicationStatus
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @hiring_process_stage_id = params['hiring_process_stage_id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?
    raise StandardError, 'Error! Hiring process not found.' unless hiring_process_stage_exists?
    raise StandardError, 'Error! Application not found.' if application_exists?

    create_application
  end

  private

  def valid_params?
    @user_id.present? &&
      @hiring_process_stage_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def hiring_process_stage_exists?
    HiringProcessStage.exists?(@hiring_process_stage_id)
  end

  def application_exists?
    application = User.find(@user_id).candidate.applications.find_by(hiring_process_stage_id: @hiring_process_stage_id)
    application.present?
  end

  def build_params(hiring_process_stage)
    {
      hiring_process_stage:
    }
  end

  def create_application
    candidate = User.find(@user_id).candidate
    hiring_process_stage = HiringProcessStage.find(@hiring_process_stage_id)
    application_params = build_params(hiring_process_stage)
    application = candidate.applications.build(application_params)
    return application if application.save

    puts "Error! : #{applications.errors.full_messages}"
    raise StandardError, "Error! : #{applications.errors.full_messages}"
  end
end
