require 'rails_helper'

RSpec.describe 'Registration Requests', type: :request do
  describe 'Sign Up' do
    subject(:do_request) { post '/users', params: params.to_json, headers: headers }

    let(:headers) { { 'Accept': 'application/json', 'Content-Type': 'application/json' } }

    context 'when submitted with valid params' do
      let(:params) do
        {
          user: {
            email: 'sample@email.com',
            password: 'complex_password'
          }
        }
      end

      it 'creates a new user' do
        expect { do_request }.to change(User, :count).by(1)
      end

      it 'responds with the user data' do
        do_request
        expect(response).to have_http_status(:created)
        expect(response.body).to eq(User.last.to_json)
      end
    end

    context 'when submitted with invalid params' do
      let(:params) do
        {
          user: {
            email: '',
            password: nil
          }
        }
      end

      it 'does not create a new user' do
        expect { do_request }.not_to change(User, :count)
      end

      it 'responds with errors json' do
        do_request

        expected_response = {
          errors: {
            email: ['can\'t be blank'],
            password: ['can\'t be blank']
          }
        }.to_json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq(expected_response)
      end
    end

    context 'when user already exists' do
      before { create(:user, email: 'existing-user@sample.com') }

      let(:params) do
        {
          user: {
            email: 'existing-user@sample.com',
            password: 'complex_password'
          }
        }
      end

      it 'does not create a new user' do
        expect { do_request }.not_to change(User, :count)
      end

      it 'responds with errors json' do
        do_request

        expected_response = {
          errors: {
            email: ['has already been taken']
          }
        }.to_json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq(expected_response)
      end
    end
  end
end
