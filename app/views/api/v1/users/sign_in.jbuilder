json_data(json) do
  json.set! :type, 'AccessToken'
  json.set! :attributes do
    json.set! :access_token, @token
  end
end
