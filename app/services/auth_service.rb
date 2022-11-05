class AuthService
  SECRET = Rails.application.secrets.secret_key_base
  EXPIRE_TIME_IN_HOURS = 8

  class << self
    attr_reader :headers

    def auth_user!(params)
      raise Exceptions::Authentication unless params[:email] && params[:password]

      user = find_user!(params)
      user.update_columns(token_issued_at: Time.current)

      # Set token_issued_at = nil means block the user.
      # If token got stolen, user could change password and trigger update token_issued_at
      raise Exceptions::Token, :blocked unless user.token_issued_at

      encrypted_token(user)
    end

    def auth_request!(headers)
      @headers = headers

      raise Exceptions::Token, :missing if headers['Authorization'].blank?
      raise Exceptions::Token, :expired if Time.current.to_i > decrypted_token[:expired_at]

      user = User.find(decrypted_token[:user_id])

      raise Exceptions::Token, :blocked unless user.token_issued_at

      user
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::Token
    end

    private

      def find_user!(params)
        user = User.find_by!(email: params[:email])
        raise Exceptions::Authentication unless user&.valid_password?(params[:password])

        user
      end

      def encrypted_token(user)
        JWT.encode({
          user_id: user.id,
          issued_at: user.token_issued_at.to_i,
          expired_at: EXPIRE_TIME_IN_HOURS.hours.from_now.to_i
        }, SECRET)
      end

      # Note that storing stuff in class variable might lead to thread-safety issue
      # because the cached result will be shared between threads
      # https://stackoverflow.com/questions/16132477/how-to-memoize-a-class-method-in-rails
      def decrypted_token
        raise Exceptions::MissingToken if headers['Authorization'].blank?

        token = headers['Authorization'].split.last
        ActiveSupport::HashWithIndifferentAccess.new JWT.decode(token, SECRET)[0]
      rescue JWT::DecodeError
        raise Exceptions::Token
      end
  end
end
