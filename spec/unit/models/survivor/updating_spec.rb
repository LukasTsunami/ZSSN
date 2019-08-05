# frozen_string_literal: true

RSpec.describe Survivor, type: :model do
  describe 'Updating a new survivor' do
    it 'should not allow to change its inventory' do
      survivor = create(:survivor, :with_inventory)
      some_random_item = create(:item)
      some_random_survivor = create(:survivor)

      first_inventory_object = survivor.inventory.first

      immutable_amount_value = first_inventory_object.amount
      immutable_survivor_association = first_inventory_object.survivor
      immutable_item_association = first_inventory_object.item

      first_inventory_object.amount = 4
      first_inventory_object.survivor = some_random_survivor
      first_inventory_object.item = some_random_item

      expect(first_inventory_object.amount).to eq(immutable_amount_value)
      expect(first_inventory_object.survivor).to eq(immutable_survivor_association)
      expect(first_inventory_object.item).to eq(immutable_item_association)
    end
  end
end
