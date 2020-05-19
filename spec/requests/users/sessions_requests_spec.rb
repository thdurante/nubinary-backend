require 'rails_helper'

RSpec.describe 'Sessions Requests', type: :request do
  let(:headers) { { 'Accept': 'application/json', 'Content-Type': 'application/json' } }

  describe 'Sign In' do
    subject(:do_request) { post '/users/sign_in', params: params.to_json, headers: headers }

    let!(:user) { create(:user, email: 'user@sample.com', password: 'password') }

    context 'with valid credentials' do
      let(:params) do
        {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      it 'responds with the user data' do
        do_request
        expect(response).to have_http_status(:created)
        expect(response.body).to eq(User.last.to_json)
      end

      it 'returns a JWT token in Authorization header' do
        do_request
        expect(response.headers.fetch('Authorization')).to match(/Bearer .+/)
      end
    end

    context 'with invalid credentials' do
      let(:params) do
        {
          user: {
            email: user.email,
            password: 'wrong_password'
          }
        }
      end

      it 'responds with errors json' do
        do_request

        expected_response = { error: 'Invalid Email or password.' }.to_json

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq(expected_response)
      end

      it 'does not return a JWT token in Authorization header' do
        do_request
        expect(response.headers['Authorization'].nil?).to be(true)
      end
    end
  end

  describe 'Sign Out' do
    let(:user) { create(:user, email: 'user@sample.com', password: 'password') }

    subject(:do_request) do
      delete '/users/sign_out', headers: Devise::JWT::TestHelpers.auth_headers(headers, user)
    end

    it 'returns a no_content response' do
      do_request
      expect(response).to have_http_status(:no_content)
    end

    it 'creates a new JwtBlacklist record' do
      expect { do_request }.to change(JwtBlacklist, :count).by(1)
    end
  end
end
