module JsonLayoutHelper
  def json_data(json)
    json.data { yield if block_given? }
  end
end
