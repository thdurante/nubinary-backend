require 'rails_helper'

RSpec.describe 'Api::V1::StringCalculations', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

  let(:authentication_headers) do
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  describe 'List' do
    subject(:do_request) do
      get '/api/v1/string_calculations', headers: authentication_headers
    end

    context 'when user is not logged in' do
      let(:authentication_headers) { headers }
      include_examples 'unauthenticated user on secured endpoint'
    end

    context 'when user is logged in' do
      it 'lists the user\'s string calculations' do
        string_calculations = create_list(:string_calculation, 2, user: user)

        do_request
        expect(response).to have_http_status(:success)
        expect(response.body).to eq({ data: string_calculations.sort_by(&:created_at).reverse }.to_json)
      end
    end
  end

  describe 'Create' do
    subject(:do_request) do
      post '/api/v1/string_calculations', params: params.to_json, headers: authentication_headers
    end

    context 'when user is not logged in' do
      let(:params) { {} }
      let(:authentication_headers) { headers }
      include_examples 'unauthenticated user on secured endpoint'
    end

    context 'when user is logged in' do
      context 'with valid params' do
        let(:params) do
          {
            string_calculation: {
              source_str: 'abcdef',
              comparing_str: 'bdf'
            }
          }
        end

        it 'creates a new string calculation' do
          expect { do_request }.to change(StringCalculation, :count).by(1)
        end

        it 'responds with success' do
          do_request
          expect(response).to have_http_status(:created)
          expect(response.body).to eq(user.reload.string_calculations.last.to_json)
        end
      end

      context 'with invalid params' do
        let(:params) do
          {
            string_calculation: {
              source_str: '',
              comparing_str: nil
            }
          }
        end

        it 'does not create a new string calculation' do
          expect { do_request }.not_to change(StringCalculation, :count)
        end

        it 'responds with success' do
          do_request
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to\
            eq({
              errors: [
                'Source str can\'t be blank',
                'Comparing str can\'t be blank'
              ]
            }.to_json)
        end
      end
    end
  end

  describe 'Destroy' do
    let!(:string_calculation) { create(:string_calculation, user: user) }

    subject(:do_request) do
      delete "/api/v1/string_calculations/#{string_calculation.id}", headers: authentication_headers
    end

    context 'when user is not logged in' do
      let(:authentication_headers) { headers }
      include_examples 'unauthenticated user on secured endpoint'
    end

    context 'when user is logged in' do
      it 'destroys the string calculation record' do
        expect { do_request }.to change(user.string_calculations, :count).by(-1)
      end

      it 'returns a no_content response' do
        do_request
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
