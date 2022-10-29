require 'rails_helper'
# require 'shared/authenticate_user'

describe Api::V1::DomainsController, type: :controller do
  describe 'GET #index' do
    before { create_list(:domain, 7) }

    def do_request(params = {})
      get :index, params: params
    end

    context 'without params' do
      it 'returns list of Domain with pagination' do
        do_request
        expect(response_data.size).to eq 5
      end
    end

    context 'with params' do
      it 'returns list of Domain with pagination' do
        do_request(page: 2)
        expect(response_data.size).to eq 2
      end
    end
  end
end
