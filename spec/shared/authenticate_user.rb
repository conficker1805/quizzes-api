shared_examples 'raises error if access_token invalid' do |method_name, params|
  context 'when token is missing' do
    before do
      allow(subject).to receive(:authorize_request).and_raise(Exceptions::MissingToken)
    end

    it 'raises token missing error' do
      method(method_name).call(params)
      expect(response_status).to eq 401
      expect(response_error_message).to eq 'Token is missing.'
    end
  end

  context 'when authoriation header is invalid' do
    before do
      allow(subject).to receive(:authorize_request).and_raise(Exceptions::InvalidToken)
    end

    it 'raises error' do
      method(method_name).call(params)
      expect(response_status).to eq 401
      expect(response_error_message).to eq 'Token is invalid.'
    end
  end
end
