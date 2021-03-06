# frozen_string_literal: true

RSpec.describe QueryInventory, type: :model do
  context 'When creating an inventory' do
    context 'passing a survivor' do
      context 'valid' do
        it 'should have the same survivor in inventory as the passed one' do
          survivor = create(:survivor)
          inventory = create(:query_inventory, survivor: survivor)

          expect(inventory.survivor).to equal(survivor)
        end
      end

      context 'invalid because it is missing' do
        it 'should raise a validation error:' do
          expect { create(:query_inventory, survivor: nil) }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'passing an item' do
      context 'valid' do
        it 'should have the same item in inventory as the passed one' do
          item = create(:item)
          inventory = create(:query_inventory, item: item)

          expect(inventory.item).to equal(item)
        end
      end

      context 'invalid because it is missing' do
        it 'should have the same item in inventory as the passed one' do
          expect { create(:query_inventory, item: nil) }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end

RSpec.describe QueryInventory, type: :model do
  context 'When trying to update an inventory by Query Object' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:survivor) }
    it { should validate_presence_of(:item) }
  end
end
