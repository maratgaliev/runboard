describe Users::ShowCommand do
  
  let(:command) { described_class.new }

  context 'show user' do
    it 'return user' do
      user = FactoryBot.create(:user)
      result = command.call(id: user.id)
      expect(result.value).to eq(user)
    end

    it 'user not found' do
      result = command.call(id: -1)
      expect(result.failure?).to be_truthy
      expect(result.value).to eq(base: ['Sorry, user not found'])
    end
  end

end
