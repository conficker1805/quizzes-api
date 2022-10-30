require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  describe 'POST #sign_in' do
    let(:user) { create(:user, password: 'a_valid_password') }

    def login_params(password = 'a_valid_password')
      {
        user: {
          email: user.email,
          password: password
        }
      }
    end

    def do_request(params = login_params)
      post :sign_in, params: params
    end

    context 'without params' do
      it 'returns errror' do
        do_request({})
        expect(response_error_message).to eq 'Bad request. Invalid parameters.'
      end
    end

    context 'when login params are INVALID' do
      before do
        allow(AuthService).to receive(:auth_user!).and_raise(Exceptions::AuthenticationError)
      end

      it 'returns authentication error' do
        do_request(login_params('invalid_password'))
        expect(response_error_message).to eq 'Authentication Failed. Please try again!'
      end
    end

    context 'when login params are VALID' do
      before do
        allow(AuthService).to receive(:auth_user!).and_return('a_valid_access_token')
      end

      it 'returns Access Token' do
        do_request
        expect(response_data_type).to eq 'AccessToken'
        expect(response_attributes[:accessToken]).to be_an String
      end
    end
  end
end
