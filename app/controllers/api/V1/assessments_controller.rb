module Api
  module V1
    class AssessmentsController < BaseController
      before_action :authorize_request

      def create
        domain = Domain.find(domain_id)

        @quizzes = Quizzes::RandomQuery.new(domain).call

        @assessment = current_user.assessments.new(
          domain: domain,
          expectation: Quizzes::RightAnswerService.new(@quizzes).call
        )

        @assessment.save
      end

      private

        def domain_id
          params.require(:domain_id)
        end
    end
  end
end
