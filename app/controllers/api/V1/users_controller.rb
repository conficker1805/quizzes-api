module Api
  module V1
    class UsersController < BaseController
      def sign_in
        @token = AuthService.auth_user!(auth_params)
      end

      private

      def auth_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
