module JsonLayoutHelper
  def json_template(json = {}, resource = nil)
    return json.data { yield if block_given? } if !resource || resource.errors.empty?

    json.errors json_errors(resource)
  end

  def json_errors(resource)
    e = resource.errors.errors.first

    {
      attribute: e.attribute,
      error: e.type,
      message: resource.errors.generate_message(e.attribute, e.type),
      messageKey: "exceptions.activerecord.#{resource.class.name.downcase}.#{e.attribute}.#{e.type}"
    }
  end
end
