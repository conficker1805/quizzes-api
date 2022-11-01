module Api
  module V1
    class BaseController < ApplicationController
      include Exceptions

      attr_reader :current_user

      helper JsonLayoutHelper
      helper AssessmentHelper

      respond_to :json

      def authorize_request
        @current_user = AuthService.auth_request!(request.headers)
      end

      protected

        def page
          params[:page] || 1
        end
    end
  end
end
