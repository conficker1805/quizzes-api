json.(resource, :id, :content)

json.set! :answers do
  json.array! resource.answers do |answer|
    json.partial! 'api/v1/shared/data_type', resource: answer
    json.partial! 'api/v1/answers/attributes', resource: answer
  end
end
