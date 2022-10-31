module Assessments
  class ExpireWorker < BaseWorker
    def perform(asssessment_id)
      assessment = Assessment.find(asssessment_id)

      return unless assessment.processing?

      assessment.expire!
    end
  end
end
