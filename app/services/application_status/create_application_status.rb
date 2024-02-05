class ApplicationStatus::CreateApplicationStatus
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @hiring_process_id = params['hiring_process_id']
    @status = params['status']
    @first = params['first']
    @second = params['second']
    @third = params['third']
    @fourth = params['fourth']
    @fifth = params['fifth']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?
    return unless hiring_process_exists?
    return if application_exists?

    create_application
  end

  private

  def valid_params?
    @user_id.present? &&
      @status.present? &&
      @first.present? &&
      @second.present? &&
      @third.present? &&
      @fourth.present? &&
      @fifth.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user.candidate.present?
  end

  def hiring_process_exists?
    HiringProcess.exists?(@hiring_process_id)
  end

  def application_exists?
    application = User.find(@user_id).candidate.applications.where(hiring_process_id: @hiring_process_id)
    application.present?
  end

  def register_application_form(application)
    application_form_params = {
      first: @first,
      second: @second,
      third: @third,
      fourth: @fourth,
      fifth: @fifth
    }
    application.create_application_form(application_form_params)
  end

  def create_application
    candidate = User.find(@user_id).candidate
    hiring_process = HiringProcess.find(@hiring_process_id)
    application_params = {
      status: @status,
      hiring_process:
    }
    application = candidate.applications.build(application_params)

    if application.save
      register_application_form(application)
      return application
    end

    puts "Erro! : #{applications.errors.full_messages}"
  end
end