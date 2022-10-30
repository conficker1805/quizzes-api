require 'rails_helper'
require 'shared/authenticate_user'

describe Api::V1::AssessmentsController, type: :controller do
  before { request.headers.merge! valid_headers_for(user) }

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:domain) { create(:domain, :with_quizzes) }

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

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:domain) { create(:domain, :with_quizzes) }
    let!(:assessment) { create(:assessment, user: user, domain: domain) }

    let(:another_user_assessment) do
      create(:assessment, user: create(:user), domain: domain)
    end

    def do_request(params = {})
      put :update, params: params
    end

    shared_examples 'returns error if can not authenticate user'

    context 'when params is missing' do
      it 'returns error' do
        do_request({ id: assessment.id })
        expect(response_error_message).to eq 'Bad request. Invalid parameters.'
      end
    end

    context 'when user try to submit answer for other questions' do
      let(:params) do
        {
          id: assessment.id,
          assessment: {
            answers: { '0' => [2] }
          }
        }
      end

      it 'returns error' do
        do_request(params)
        expect(response_error_message).to eq 'Answers format is invalid.'
      end
    end

    context 'when assessment belongs to another user' do
      let(:params) do
        {
          id: another_user_assessment.id,
          assessment: {
            answers: {}
          }
        }
      end

      it 'returns error' do
        do_request(params)
        expect(response_error_message).to eq 'Resource not found.'
      end
    end

    context 'when user try to submit answers for an expire assessment' do
      let(:params) do
        {
          id: assessment.id,
          assessment: {
            answers: Quizzes::RightAnswerService.new(assessment.quizzes).call
          }
        }
      end

      before do
        allow(Time).to receive(:current).and_return(1.day.from_now)
      end

      it 'saves answers & return errors' do
        do_request(params)
        expect(response_error_message).to eq 'The assessment has been ended'
        expect(assessment.reload.state).to eq 'expired'
        expect(assessment.answers).to be_present
      end
    end

    context 'when user try to submit answers while state != processing' do
      let(:params) do
        {
          id: assessment.id,
          assessment: {
            answers: Quizzes::RightAnswerService.new(assessment.quizzes).call
          }
        }
      end

      before { assessment.expire! }

      it 'returns errors' do
        do_request(params)
        expect(response_error_message).to eq 'Resource not found.'
        expect(assessment.reload.state).to eq 'expired'
        expect(assessment.answers).not_to be_present
      end
    end

    context 'when user answers are valid and correct' do
      let(:params) do
        {
          id: assessment.id,
          assessment: {
            answers: Quizzes::RightAnswerService.new(assessment.quizzes).call
          }
        }
      end

      it 'saves answers & return the result' do
        do_request(params)
        expect(response_attributes[:state]).to eq 'completed'
        expect(response_attributes[:answers]).to be_present
        expect(response_attributes[:score]).to eq '5/5'
      end
    end

    context 'when user answers are valid and not correct' do
      let(:correct_answers) { Quizzes::RightAnswerService.new(assessment.quizzes).call }
      let(:params) do
        {
          id: assessment.id,
          assessment: {
            answers: Hash[*correct_answers.first]
          }
        }
      end

      it 'saves answers & return the result' do
        do_request(params)
        expect(response_attributes[:state]).to eq 'completed'
        expect(response_attributes[:answers]).to be_present
        expect(response_attributes[:score]).to eq '1/5'
      end
    end
  end
end
