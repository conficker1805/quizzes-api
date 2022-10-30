shared_examples 'returns error if can not authenticate user' do
  context 'when authoriation header is missing' do
    before do
      allow(subject).to receive(:authorize_request).and_raise(Exceptions::MissingToken)
    end

    it 'raises error' do
      do_request
      expect(response_error_message).to eq 'Token is missing.'
    end
  end

  context 'when authoriation header is invalid' do
    before do
      allow(subject).to receive(:authorize_request).and_raise(Exceptions::InvalidToken)
    end

    it 'raises error' do
      do_request
      expect(response_error_message).to eq 'Token is invalid.'
    end
  end
end
