module Exceptions
  extend ActiveSupport::Concern

  DEFAULT_MSG = 'System Error, please contact admin for more information'.freeze
  CUSTOM_ERRORS = %w[
    AuthenticationError
    MissingToken
    InvalidToken
    AssessmentTimeOut
  ].freeze

  RAILS_ERRORS = [
    ActionController::ParameterMissing,
    ActiveRecord::RecordNotFound
  ].freeze

  CUSTOM_ERRORS.each do |name|
    Exceptions.const_set(name, Class.new(StandardError))
  end

  included do
    rescue_from(*(CUSTOM_ERRORS + RAILS_ERRORS), with: :render_api_error)
    rescue_from(ActiveRecord::RecordInvalid, with: :render_model_errors)
  end

  private

    def render_model_errors(exception)
      resource = exception.record
      e = resource.errors.errors.first
      message_key = "exceptions.activerecord.#{resource.class.name.downcase}.#{e.attribute}.#{e.type}"

      render json: {
               errors: {
                 attribute: e.attribute,
                 error: e.type,
                 message: resource.errors.generate_message(e.attribute, e.type),
                 messageKey: message_key
               }
             },
             status: :unprocessable_entity
    end

    def render_api_error(exception)
      @translation = exception.class.name.split('::').map(&:underscore).join('.')
      @translation.prepend(prefix) unless @translation.start_with?(prefix)
      @message = I18n.t("#{@translation}.message", scope: 'api')
      @status  = I18n.t("#{@translation}.status", scope: 'api', default: 400)

      render template: 'api/errors', status: @status
    end

    def prefix
      'exceptions.'
    end
end
