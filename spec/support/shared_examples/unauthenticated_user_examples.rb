RSpec.shared_examples 'unauthenticated user on secured endpoint' do
  it 'returns an unauthorized response' do
    do_request
    expect(response).to have_http_status(:unauthorized)
    expect(response.body).to eq({ error: 'You need to sign in or sign up before continuing.' }.to_json)
  end
end
