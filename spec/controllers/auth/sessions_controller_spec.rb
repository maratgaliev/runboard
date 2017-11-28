describe Auth::SessionsController, type: :request do
  describe 'POST /users/sign_in' do
    let(:email) { 'test@test.com' }
    let(:request_password) { 'password' }
    let!(:user) { FactoryBot.create(:user, email: email, password: 'password', name: 'name', phone: '89033556128', bio: 'bio', position: 'position') }

    before do
      headers = { 'Content-Type' => 'application/json' }
      params = { user: { email: email, password: request_password } }

      post '/users/sign_in', headers: headers, params: params.to_json
    end

    subject { response }

    context 'invalid credentials' do
      let(:request_password) { '123' }

      its(:status) { is_expected.to eq 422 }
      its(:body) { is_expected.to eq '{"error":{"base":["Sorry, invalid email or password"]}}' }
    end

    context 'valid credentials' do
      its(:status) { is_expected.to eq 200 }
      its(:body) { is_expected.to match /user/ }

      it 'authorization header should exists' do
        expect(response.headers['Authorization']).to match /^Bearer/
      end
    end
  end
end
