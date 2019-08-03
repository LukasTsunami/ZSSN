# frozen_string_literal: true

RSpec.describe Survivor do
  describe 'Creating a new survivor' do
    context 'when data is valid' do
      let(:survivor) { create(:survivor, :with_inventory) }

      it 'should return a new survivor' do
        expect(survivor).to be_valid
      end

      it 'should return a new survivor with an inventory' do
        expect(survivor.inventory).not_to be_nil
      end

      it 'should return a new survivor with an inventory, and direct access to its item list' do
        expect(survivor.items).not_to be_nil
      end
    end
  end
  describe 'Changing infected status' do
    it 'should infect all its items too' do
      item = double(create(:item))
      expect(item).to receive(:items_infected_by_survivor).and change(item, :infected)
      expect_any_instance_of(Survivor).to receive(:infected_survivor).and_return(true)
      create(:survivor)
    end
  end
end


