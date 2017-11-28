describe UsersController, type: :request do
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
end
