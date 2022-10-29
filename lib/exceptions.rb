module Exceptions
  extend ActiveSupport::Concern

  DEFAULT_MSG = 'System Error, please contact admin for more information'
  CUSTOM_ERRORS  = %w[ AuthenticationError MissingToken InvalidToken ]
  RAILS_ERRORS = [
    ActionController::ParameterMissing,
    ActiveRecord::RecordNotFound
  ]

  CUSTOM_ERRORS.each do |name|
    Exceptions.const_set(name, Class.new(StandardError))
  end

  included do
    rescue_from *(CUSTOM_ERRORS + RAILS_ERRORS), with: :json_error_message
  end

  private

  def json_error_message(exception)
    @translation = exception.class.name.split('::').map(&:underscore).join('.')
    @translation.prepend(prefix) if !@translation.start_with?(prefix)
    @message = I18n.t(@translation + '.message', scope: 'api')
    @status  = I18n.t(@translation + '.status', scope: 'api', default: 400)

    render template: 'api/errors', status: @status
  end

  def prefix
    'exceptions.'
  end
end
