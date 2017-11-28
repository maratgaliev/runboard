describe Users::MainQuery do
  
  let!(:user) { FactoryBot.create(:user) }

  context 'index' do
    it 'paginate users' do
      stub_const('Users::MainQuery::PER_PAGE', 1)
      expect(described_class.index_query.value).to match_array [user]
    end
  end

end
