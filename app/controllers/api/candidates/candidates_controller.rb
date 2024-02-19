module Api
  module Candidates
    class CandidatesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        candidate_params = create_candidate_permitted_params
        body = UserCandidate::CreateCandidate.run(candidate_params, @payload)
        render status: :ok, body: body.to_json
      end

      private

      def create_candidate_permitted_params
        params.permit(:name, :email, :phone_number1, :phone_number2, :employee, :resume, :birthplace, :gender,
                      :birthdate, :marital_status, :address_neighborhood, :address_city, :mother_name, :spouse_name,
                      :number_of_children, :residence_status, :possessions, :other_incomes, :relatives_in_company,
                      :smoker, :alcohol_consumer, :medication_user, :first_question, :second_question, :third_question,
                      :fourth_question, :fifth_question, :curriculum)
      end

      def authorize!
        token = extract_token_from_request
        @payload = user?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
