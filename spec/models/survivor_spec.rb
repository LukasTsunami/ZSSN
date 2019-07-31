RSpec.describe Survivor do
  describe 'Creating a new survivor' do
    context 'when data is valid' do
      it 'should return a new survivor' do
        survivor = create(:survivor)
        expect(survivor).to be_valid
      end
    end
  end
end
