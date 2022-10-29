module Api
  module V1
    class AssessmentsController < BaseController
      def create
        # assessment = Assessment.new(assessment_params)

        # if @assessment.save
        #   redirect_to assessment_path(@assessment), notice: t('flash_message.assessment.create.success')
        # else
        #   render :new
        # end
      end

      private

        def assessment_params
          params.require(:assessment).permit(:domain_id)
        end
    end
  end
end
