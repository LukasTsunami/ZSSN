# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory, type: :model do
  context 'When creating an inventory' do
    context 'passing a survivor' do
      context 'valid' do
        it 'should have the same survivor in inventory as the passed one' do
          survivor = create(:survivor)
          inventory = create(:inventory, survivor: survivor)

          expect(inventory.survivor).to equal(survivor)
        end
      end

      context 'invalid because it is missing' do
        it 'should raise a validation error:' do
          message = 'Validation failed: Survivor must exist'
          expect { create(:inventory, survivor: nil) }.to raise_error(ActiveRecord::RecordInvalid, message)
        end
      end
    end

    context 'passing an item' do
      context 'valid' do
        it 'should have the same item in inventory as the passed one' do
          item = create(:item)
          inventory = create(:inventory, item: item)

          expect(inventory.item).to equal(item)
        end
      end

      context 'invalid because it is missing' do
        it 'should have the same item in inventory as the passed one' do
          message = 'Validation failed: Item must exist'
          expect { create(:inventory, item: nil) }.to raise_error(ActiveRecord::RecordInvalid, message)
        end
      end
    end
  end
end
