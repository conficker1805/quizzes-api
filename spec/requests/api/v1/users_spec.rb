require 'swagger_helper'

RSpec.describe 'api/v1/users' do
  path '/api/v1/users/sign_in' do
    post('Sign in') do
      consumes 'application/json'
      security []

      parameter in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
            }
          },
        },
        example: {
          user: {
            email: 'user@example.com',
            password: 'your_password'
          }
        },
        required: %w[email password],
      }

      response(200, 'OK') do
        example 'application/json', 'Credential is valid', {
          data: {
            type: 'AccessToken',
            attributes: {
              accessToken: 'eyJhbGciOJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ._16TRwEqsZycuaSDMCaQLTJw0cFn1gc0GyPc545dE'
            }
          }
        }

        run_test!
      end

      response(401, 'Unauthorized') do
        example 'application/json', 'Email or Password is invalid', {
          errors: {
            message: 'Authentication Failed. Please try again!',
            messageKey: 'exceptions.authentication_error'
          }
        }

        run_test!
      end
    end
  end
end
