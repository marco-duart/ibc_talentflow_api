module UserCandidate
  class CreateCandidate
    def self.run(params, payload)
      new(params, payload).run
    end

    def initialize(params, payload)
      @id = payload['user_id']
      @phone_number1 = params['phone_number1']
      @phone_number2 = params['phone_number2']
      @employee = params['employee']
      @resume = params['resume']
      @portfolio = params['portfolio']
      @skills = params['skills']
    end

    def run
      return unless valid_params?
      return unless user_exists?

      create_candidate
    end

    private

    def valid_params?
      @id.present? && @phone_number1.present? && @phone_number2.present? && @employee.present? && @resume.present? && @portfolio.present? && @skills.present?
    end

    def user_exists?
      User.exists?(@id)
    end

    def create_candidate
      user = User.find(@id)
      candidate_params = {
        name: user.name,
        email: user.email,
        phone_number1: @phone_number1,
        phone_number2: @phone_number2,
        employee: @employee == 'true',
        resume: @resume,
        portfolio: @portfolio,
        skills: @skills
      }
      candidate = user.create_candidate(candidate_params)
      return 'Ok' if candidate.save

      'Deu ruim'
    end
  end
end
