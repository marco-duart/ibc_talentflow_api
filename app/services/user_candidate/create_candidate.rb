# rubocop:disable Metrics
class UserCandidate::CreateCandidate
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @id = payload['user_id']
    @phone_number1 = params['phone_number1']
    @phone_number2 = params['phone_number2']
    @employee = params['employee']
    @resume = params['resume']
    @birthplace = params['birthplace']
    @gender = params['gender']
    @birthdate = params['birthdate']
    @marital_status = params['marital_status']
    @address_neighborhood = params['address_neighborhood']
    @address_city = params['address_city']
    @mother_name = params['mother_name']
    @spouse_name = params['spouse_name']
    @number_of_children = params['number_of_children']
    @residence_status = params['residence_status']
    @possessions = params['possessions']
    @other_incomes = params['other_incomes']
    @relatives_in_company = params['relatives_in_company']
    @pcd = params['pcd']
    @smoker = params['smoker']
    @alcohol_consumer = params['alcohol_consumer']
    @medication_user = params['medication_user']
    @first_question = params['first_question']
    @second_question = params['second_question']
    @third_question = params['third_question']
    @fourth_question = params['fourth_question']
    @fifth_question = params['fifth_question']
    @curriculum = params['curriculum']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    return unless user_exists?

    create_candidate
  end

  private

  def valid_params?
    @id.present? &&
      @phone_number1.present? &&
      @phone_number2.present? &&
      @employee.present? &&
      @resume.present? &&
      @birthplace.present? &&
      @gender.present? &&
      @birthdate.present? &&
      @marital_status.present? &&
      @address_neighborhood.present? &&
      @address_city.present? &&
      @mother_name.present? &&
      @spouse_name.present? &&
      @number_of_children.present? &&
      @residence_status.present? &&
      @possessions.present? &&
      @other_incomes.present? &&
      @relatives_in_company.present? &&
      @pcd.present? &&
      @smoker.present? &&
      @alcohol_consumer.present? &&
      @medication_user.present?
  end

  def user_exists?
    User.exists?(@id)
  end

  def register_cpf(user)
    user.candidate.documents.create({
                                      document_name: 'CPF',
                                      document_number: user.cpf
                                    })
  end

  def build_params(user)
    {
      name: user.name,
      email: user.email,
      phone_number1: @phone_number1,
      phone_number2: @phone_number2,
      employee: @employee,
      resume: @resume,
      birthplace: @birthplace,
      gender: @gender,
      birthdate: @birthdate,
      marital_status: @marital_status,
      address_neighborhood: @address_neighborhood,
      address_city: @address_city,
      mother_name: @mother_name,
      spouse_name: @spouse_name,
      number_of_children: @number_of_children,
      residence_status: @residence_status,
      possessions: @possessions,
      other_incomes: @other_incomes,
      relatives_in_company: @relatives_in_company,
      pcd: @pcd,
      smoker: @smoker,
      alcohol_consumer: @alcohol_consumer,
      medication_user: @medication_user,
      first_question: @first_question,
      second_question: @second_question,
      third_question: @third_question,
      fourth_question: @fourth_question,
      fifth_question: @fifth_question
    }
  end

  def attach_curriculum(candidate)
    candidate.curriculum.attach(@curriculum)
  end

  def create_candidate
    user = User.find(@id)
    candidate_params = build_params(user)
    candidate = user.build_candidate(candidate_params)
    attach_curriculum(candidate) if @curriculum
    if candidate.save
      register_cpf(user)
      return {
        message: 'Successfull to create a new candidate!',
        candidate:
      }
    end

    puts "Error! : #{candidate.errors.full_messages}"
    raise StandardError, "Error! : #{candidate.errors.full_messages}"
  end
end
