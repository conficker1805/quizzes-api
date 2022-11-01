require 'swagger_helper'

RSpec.describe 'api/v1/domains' do
  path '/api/v1/domains' do
    get('Fetch list of domains') do
      response(200, 'OK') do
        consumes 'application/json'
        security []

        parameter name: :page,
                  in: :query,
                  type: :integer,
                  description: 'Page number. Default: 1',
                  required: false

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
