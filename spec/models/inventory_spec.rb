require 'rails_helper'

RSpec.describe Inventory, type: :model do
  context 'When creating an inventory' do
    context 'passing a valid survivor' do
      it 'should have the same survivor in inventory as the passed one' do
        survivor = create(:survivor)
        inventory = create(:inventory, survivor: survivor)
        
        expect(inventory.survivor).to equal(survivor)
      end
    end

    context 'passing a valid item' do
      it 'should have the same item in inventory as the passed one' do
        item = create(:item)
        inventory = create(:inventory, item: item)
        
        expect(inventory.item).to equal(item)
      end
    end
  end
end
