class AuthService
  SECRET = Rails.application.secrets.secret_key_base

  class << self
    attr_reader :headers, :user

    def auth_user!(params)
      raise Exceptions::AuthenticationError unless params[:email] && params[:password] && find_user(params)

      JWT.encode({ user_id: @user.id }, SECRET)
    end

    def auth_request!(headers)
      @headers = headers
      @user = User.find(decrypted_token[:user_id]) if decrypted_token
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::InvalidToken
    end

    private

      def find_user(params)
        @user = User.find_by!(email: params[:email])
        raise Exceptions::AuthenticationError unless @user&.valid_password?(params[:password])

        @user
      end

      def decrypted_token
        raise Exceptions::MissingToken if headers['Authorization'].blank?

        token = headers['Authorization'].split.last
        ActiveSupport::HashWithIndifferentAccess.new JWT.decode(token, SECRET)[0]
      rescue JWT::DecodeError
        raise Exceptions::InvalidToken
      end
  end
end
