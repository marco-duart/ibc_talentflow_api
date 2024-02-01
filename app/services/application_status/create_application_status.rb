class ApplicationStatus::CreateApplicationStatus
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @hiring_process_id = params['hiring_process_id']
    @status = params['status']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?
    return unless hiring_process_exists?

    create_application
  end

  private

  def valid_params?
    @user_id.present? &&
      @status.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user.candidate.present?
  end

  def hiring_process_exists?
    HiringProcess.exists?(@hiring_process_id)
  end

  def create_application
    candidate = User.find(@user_id).candidate
    hiring_process = HiringProcess.find(@hiring_process_id)
    application_params = {
      status: @status,
      hiring_process:
    }
    application = candidate.applications.build(application_params)

    return application if application.save

    puts "Erro! : #{applications.errors.full_messages}"
  end
end
