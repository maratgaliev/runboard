describe UsersController, type: :request do

  let!(:user) { FactoryBot.create(:user) }

  let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user) }

  let(:auth_headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token}"
    }
  end

  describe 'GET /users' do
    let!(:user) { FactoryBot.create(:user) }

    before do
      headers = { 'Content-Type' => 'application/json' }

      get '/users', headers: headers
    end

    subject { response }

    context 'users index' do
      its(:status) { is_expected.to eq 200 }
      its(:body) { is_expected.to match /users/ }

      describe 'user' do
        subject { User.last }

        its(:email) { is_expected.to eq user.email }
        its(:login) { is_expected.to eq user.login }
      end
    end

  end

  subject { response }

  describe 'GET /users/:id' do
    context 'empty JWT token' do
      before { get "/users/#{user.id}", headers: { 'Content-Type' => 'application/json' } }
      its(:status) { is_expected.to eq 401 }
    end

    context 'with JWT token' do
      let(:user) { FactoryBot.create(:user) }

      before { get "/users/#{user.id}", headers: auth_headers }

      its(:status) { is_expected.to eq 200 }

      describe 'response JSON' do
        let(:json_response) { JSON.parse(response.body) }

        it 'should contain user' do
          expect(json_response.key?('user')).to eq true
          expect(json_response['user']['id']).to eq user.id
        end
      end
    end
  end
end

