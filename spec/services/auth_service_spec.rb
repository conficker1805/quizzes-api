require 'rails_helper'

describe AuthService do
  let!(:user) { create :user, password: 'a_valid_password' }

  describe '#auth_user!' do
    context 'when params is missing' do
      let(:invalid_params) { { email: user.email } }

      it 'return errors' do
        expect { described_class.auth_user!(invalid_params) }.to raise_error(Exceptions::AuthenticationError)
      end
    end

    context 'when email/password does NOT MATCH database' do
      let(:invalid_params) { { email: user.email, password: 'an_invalid_password' } }

      before do
        allow(described_class).to receive(:find_user).and_raise(Exceptions::AuthenticationError)
      end

      it 'return errors' do
        expect { described_class.auth_user!(invalid_params) }.to raise_error(Exceptions::AuthenticationError)
      end
    end

    context 'when email/password is MATCH database' do
      let(:valid_params) { { email: user.email, password: 'a_valid_password' } }

      before do
        allow(described_class).to receive(:find_user).and_return(user)
        described_class.instance_variable_set :@user, user
      end

      it 'returns access token' do
        expect(described_class.auth_user!(valid_params)).to be_an String
      end
    end
  end

  describe '#find_user' do
    context 'when email does not exist' do
      it 'returns errors' do
        expect {
          described_class.send(:find_user, { email: "invalid_email@example.com", password: 'a_valid_password' })
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when email is exist but password does not match' do
      it 'returns errors' do
        expect {
          described_class.send(:find_user, { email: user.email, password: 'an_invalid_password' })
        }.to raise_error(Exceptions::AuthenticationError)
      end
    end

    context 'when email and password are match' do
      it 'returns a user' do
        found_user = described_class.send(:find_user, { email: user.email, password: 'a_valid_password' })
        expect(found_user).to eq user
      end
    end
  end
end
