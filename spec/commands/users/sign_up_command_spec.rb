describe Users::SignUpCommand do
  
  let(:command) { described_class.new }

  context 'email error' do
    it 'invalid format' do
      result = command.call(email: 'email', login: 'login', password: 'password', name: 'name', phone: '89033556128', bio: 'bio', position: 'position')

      expect(result.failure?).to be_truthy
      expect(result.value).to eq(email: ['Invalid email format'])
    end

    it 'email already exists' do
      user = FactoryBot.create(:user)

      result = command.call(email: user.email, login: 'login', password: 'password', name: 'name', phone: '89033556128', bio: 'bio', position: 'position')

      expect(result.failure?).to be_truthy
      expect(result.value).to eq(email: ['has already been taken'])
    end
  end

  context 'login error' do
    it 'invalid format' do
      result = command.call(email: 'test@test.com', login: 'l', password: 'password', name: 'name', phone: '89033556128', bio: 'bio', position: 'position')

      expect(result.failure?).to be_truthy
      expect(result.value).to eq(login: ['size cannot be less than 3'])
    end

    it 'login already exists' do
      user = FactoryBot.create(:user)

      result = command.call(email: 'test@test.com', login: user.login, password: 'password', name: 'name', phone: '89033556128', bio: 'bio', position: 'position')

      expect(result.failure?).to be_truthy
      expect(result.value).to eq(login: ['Sorry, login already has been taken'])
    end
  end

  context 'password error' do
    it 'invalid format' do
      result = command.call(email: 'test@test.com', login: 'login', password: 'pass', name: 'name', phone: '89033556128', bio: 'bio', position: 'position')

      expect(result.failure?).to be_truthy
      expect(result.value).to eq(password: ['Password must be at least 6 characters'])
    end
  end

  context 'success save' do
    let(:result) { command.call(email: 'test@test.com', login: 'login', password: 'password', name: 'name', phone: '89033556128', bio: 'bio', position: 'position') }

    subject { result }

    its(:success?) { is_expected.to be_truthy }

    describe 'user' do
      subject { result.value }

      its(:persisted?) { is_expected.to be_truthy }
      its(:email) { is_expected.to eq 'test@test.com' }
      its(:login) { is_expected.to eq 'login' }
    end
  end
end
