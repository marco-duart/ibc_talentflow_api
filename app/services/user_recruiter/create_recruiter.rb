module UserRecruiter
  class CreateRecruiter
    def self.run(params, payload)
      new(params, payload).run
    end

    def initialize(params, payload)
      @id = payload['user_id']
      @position = params['position']
    end

    def run
      return unless valid_params?
      return unless user_exists?

      create_recruiter
    end

    private

    def valid_params?
      @id.present? && @position.present?
    end

    def user_exists?
      User.find(@id)
    end

    def create_recruiter
      user = User.find(@id)
      recruiter_params = {
        name: user.name,
        email: user.email,
        position: @position
      }
      recruiter = user.build_recruiter(recruiter_params)
      return 'Ok' if recruiter.save

      'Deu ruim'
    end
  end
end
