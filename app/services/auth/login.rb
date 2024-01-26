module Auth
    class Login
      include BCrypt
  
      def self.run(params)
        new(params).run
      end
  
      def initialize(params)
        @cpf = params['cpf']
        @password = params['password']
      end
  
      def run
        auth_user
        get_token
      end
  
      private
  
      def auth_user
        return unless @cpf
        @user = User.where(cpf: @cpf)

        return unless user

        if user.password == @password
          return "Ok!!!!!!!!"
        end
      end
  
    end
  end
  