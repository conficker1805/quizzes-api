module ExceptionHandler
  def listening_exception
    yield
  rescue ActionView::Template::Error => e
    raise e
  rescue NameError => e
    render json: { message: (Rails.env.production? ? I18n.t('shared.other.something_wrong') : e.message) },
           status: :internal_server_error
  rescue StandardError => e
    res = ExceptionFormat.new(e)
    render json: { message: res.message }, status: res.status
  end
end
