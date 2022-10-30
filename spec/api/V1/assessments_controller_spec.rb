require 'rails_helper'
require 'shared/authenticate_user'

describe Api::V1::AssessmentsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:domain) { create(:domain, :with_quizzes) }

    before { request.headers.merge! valid_headers_for(user) }

    def do_request(params = {})
      post :create, params: params
    end

    include_examples 'returns error if can not authenticate user'

    context 'without domain_id' do
      it 'returns error' do
        do_request({})
        expect(response_error_message).to eq 'Bad request. Invalid parameters.'
      end
    end

    context 'when the domain does not exist' do
      it 'returns error' do
        do_request({ domain_id: 0 })
        expect(response_error_message).to eq 'Resource not found.'
      end
    end

    context 'when assessment is VALID' do
      it 'returns assignment' do
        do_request({ domain_id: domain.id })
        expect(response_data_type).to eq 'Assessment'
        expect(response_attributes[:userId]).to eq user.id
        expect(response_attributes[:state]).to eq 'processing'
        expect(response_attributes[:domainId]).to eq domain.id
        expect(response_attributes[:quizzes].size).to eq 5
        expect(response_attributes[:expectation]).to be_nil
      end
    end
  end
end
