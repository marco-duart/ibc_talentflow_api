class ApplicationStatus::FetchApplicationStatus
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @role = payload['role']
    @application_id = params['id']
  end

  def run
    return unless valid_params?

    @application_id ? fetch_by_id : fetch_all
  end

  private

  def access_all?
    @role == 'admin' || @role == 'ti'
  end

  def valid_params?
    @user_id.present?
  end

  def fetch_all
    return ApplicationStatus.all if access_all?

    User.find(@user_id).candidate.applications
  end

  def build_response(application)
    {
      job_name: application.hiring_process_stage.hiring_process.job_posting.title,
      stage: application.hiring_process_stage.title,
      application:
    }
  end

  def fetch_by_id
    application = access_all? ? ApplicationStatus.find(@application_id) : User.find(@user_id).candidate.applications.find(@application_id) # rubocop:disable Layout/LineLength
    return build_response(application) if application

    puts "Error! : #{application.errors.full_messages}"
  end
end
