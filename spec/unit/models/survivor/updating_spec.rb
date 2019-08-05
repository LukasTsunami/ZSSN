# frozen_string_literal: true

RSpec.describe Survivor, type: :model do
  describe 'Updating a new survivor' do
    before(:all) do 
      @survivor = create(:survivor, :with_query_inventory_and_two_items)
      @first_inventory_object = @survivor.inventory.first
    end

    it 'should not allow to change its inventory #amount' do
      @first_inventory_object.amount = 4
      expect{ @first_inventory_object.save }.to raise_error("QueryInventory is marked as readonly")
    end

    it 'should not allow to change its inventory #survivor' do
      @first_inventory_object.survivor = create(:survivor)
      expect{ @first_inventory_object.save }.to raise_error("QueryInventory is marked as readonly")
    end

    it 'should not allow to change its inventory #item' do
      @first_inventory_object.item = create(:item)
      expect{ @first_inventory_object.save }.to raise_error("QueryInventory is marked as readonly")
    end
  end
end
