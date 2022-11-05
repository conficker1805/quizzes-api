require 'rails_helper'

describe AuthService do
  let!(:user) { create(:user, password: 'valid_password') }

  describe '#auth_user!' do
    context 'when params is missing' do
      let(:invalid_params) { { email: user.email } }

      it 'return errors' do
        expect { described_class.auth_user!(invalid_params) }.to raise_error(Exceptions::Authentication)
      end
    end

    context 'when email/password does NOT MATCH database' do
      let(:invalid_params) { { email: user.email, password: 'an_invalid_password' } }

      before do
        allow(described_class).to receive(:find_user!).and_raise(Exceptions::Authentication)
      end

      it 'return errors' do
        expect { described_class.auth_user!(invalid_params) }.to raise_error(Exceptions::Authentication)
      end
    end

    context 'when the user is blocked by admin' do
      let(:valid_params) { { email: user.email, password: 'valid_password' } }

      before do
        allow_any_instance_of(User).to receive(:token_issued_at).and_return(nil)
      end

      it 'returns error' do
        expect do
          described_class.auth_user!(valid_params)
        end.to raise_error(Exceptions::Token, 'blocked')
      end
    end

    context 'when email/password is MATCH database' do
      let(:valid_params) { { email: user.email, password: 'valid_password' } }

      before do
        allow(described_class).to receive(:find_user!).and_return(user)
        described_class.instance_variable_set :@user, user
      end

      it 'returns access token' do
        expect(described_class.auth_user!(valid_params)).to be_an String
      end
    end
  end

  describe '#auth_request!' do
    let(:valid_headers) { valid_headers_for(user) }
    let(:invalid_headers) { { 'Authorization' => 'invalid' } }

    context 'when authenticating user successfully' do
      it 'returns authenticated user' do
        expect(described_class.auth_request!(valid_headers)).to eq user
      end
    end

    context 'when access token is missing' do
      it 'returns error' do
        expect { described_class.auth_request!({}) }.to raise_error(Exceptions::Token, 'missing')
      end
    end

    context 'when access token is INVALID' do
      it 'returns error' do
        expect { described_class.auth_request!(invalid_headers) }.to raise_error(Exceptions::Token)
      end
    end

    context 'when access token is EXPIRED' do
      before do
        allow(described_class).to receive(:decrypted_token).and_return({
          user_id: 0,
          expired_at: 5.minutes.ago.to_i
        })
      end

      it 'returns error' do
        expect do
          described_class.auth_request!({ 'Authorization' => 'a_valid_token' })
        end.to raise_error(Exceptions::Token, 'expired')
      end
    end

    context 'when the user is not found' do
      before do
        allow(described_class).to receive(:decrypted_token).and_return({
          user_id: 0,
          expired_at: described_class::EXPIRE_TIME_IN_HOURS.hours.from_now.to_i
        })
      end

      it 'returns error' do
        expect do
          described_class.auth_request!({ 'Authorization' => 'a_valid_token' })
        end.to raise_error(Exceptions::Token)
      end
    end

    context 'when the user is blocked by admin' do
      before do
        allow_any_instance_of(User).to receive(:token_issued_at).and_return(nil)
      end

      it 'returns error' do
        expect do
          described_class.auth_request!(valid_headers_for(user))
        end.to raise_error(Exceptions::Token, 'blocked')
      end
    end
  end

  describe '#find_user' do
    context 'when email does not exist' do
      it 'returns errors' do
        expect do
          described_class.send(:find_user!, { email: 'invalid@example.com', password: 'valid_password' })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when email is exist but password does not match' do
      it 'returns errors' do
        expect do
          described_class.send(:find_user!, { email: user.email, password: 'an_invalid_password' })
        end.to raise_error(Exceptions::Authentication)
      end
    end

    context 'when email and password are match' do
      it 'returns a user' do
        found_user = described_class.send(:find_user!, { email: user.email, password: 'valid_password' })
        expect(found_user).to eq user
      end
    end
  end
end
