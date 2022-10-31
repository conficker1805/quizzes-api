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

        @assessment.save!
      end

      def update
        @assessment = current_user.assessments.find_by!(id: id, state: :processing)
        @assessment.assign_attributes(assessment_params)

        # When timeout at FE, it will trigger submit the answers automatically
        # 5 seconds is the extended time for submitting user's answers
        valid_time = Time.current.between?(@assessment.started_at, @assessment.ended_at + 5.seconds)
        valid_time ? @assessment.complete : @assessment.expire

        # Save user's answer even the time is valid or not
        @assessment.save!

        raise Exceptions::AssessmentTimeOut unless valid_time
      end

      private

        def id
          params.require(:id)
        end

        def domain_id
          params.require(:domain_id)
        end

        def assessment_params
          params.require(:assessment).permit(answers: {})
        end
    end
  end
end
