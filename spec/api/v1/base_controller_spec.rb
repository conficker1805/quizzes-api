require 'rails_helper'

describe Api::V1::BaseController, type: :controller do
  describe '#authorize_request' do
    context 'when authenticating user successfully' do
      let(:user) { create(:user) }

      before do
        allow(AuthService).to receive(:auth_request!).and_return(user)
      end

      it 'returns user' do
        expect(subject.authorize_request).to eq user
      end
    end

    context 'when authenticating user failure' do
      before do
        allow(AuthService).to receive(:auth_request!).and_raise(Exceptions::InvalidToken)
      end

      it 'returns error' do
        expect { subject.authorize_request }.to raise_error(Exceptions::InvalidToken)
      end
    end
  end
end
