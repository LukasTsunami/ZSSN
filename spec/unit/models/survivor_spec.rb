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

  context 'Updating a survivor' do
    it { is_expected.to callback(:infect_inventory).after(:update).if :saved_change_to_infected? }
  end
end
