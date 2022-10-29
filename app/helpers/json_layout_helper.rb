module JsonLayoutHelper
  def json_template(json = {}, resource = nil)
    return json.data { yield if block_given? } if !resource || resource.errors.empty?

    errors = resource.errors.errors.map do |e|
      message = resource.errors.generate_message(e.attribute, e.type)
      { attribute: e.attribute, error: e.type, message: message }
    end

    json.errors errors
  end
end
