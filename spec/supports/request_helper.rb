module RequestHelper
  def response_body(wrap)
    @_response_body ||= JSON.parse(response.body).with_indifferent_access[wrap]
  rescue JSON::ParserError
    nil
  end

  def response_data_type
    response_body(:data)[:type]
  end

  def response_attributes
    response_body(:data)[:attributes]
  end

  def response_data
    response_body(:data)
  end

  def response_error
    response_body(:errors)
  end

  def response_error_message
    response_body(:errors)[:message]
  end

  def valid_headers_for(user)
    token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
    { 'Authorization' => "Bearer #{token}" }
  end
end
