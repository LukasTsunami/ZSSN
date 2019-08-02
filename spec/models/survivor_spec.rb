# frozen_string_literal: true

RSpec.describe Survivor do
  describe 'Creating a new survivor' do
    context 'when data is valid' do
      it 'should return a new survivor' do
        survivor = create(:survivor)
        expect(survivor).to be_valid
      end

      it 'should return a new survivor with an inventory' do
        survivor = create(:survivor)
        expect(survivor.inventory.exists?).to be_valid
      end

      it 'should return a new survivor with an inventory, and direct access to its item list' do
        survivor = create(:survivor)
        expect(survivor.items.exists?).to be_valid
      end
    end
  end
end
