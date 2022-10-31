json_data(json) do
  json.array! @domains do |domain|
    json.partial! 'api/v1/shared/data_type', resource: domain
    json.partial! 'api/v1/domains/attributes', resource: domain
  end
end

json.partial! 'api/v1/shared/meta', resources: @domains
