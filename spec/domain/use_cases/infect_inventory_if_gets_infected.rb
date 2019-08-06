# frozen_string_literal: true

RSpec.describe Survivor, type: :model do
  context 'When a survivor gets infected' do
    it 'its invetory should be infected too' do
      survivor = create(:survivor, :with_query_inventory, infected: false)
      survivor.infected = true
      survivor.save

      survivor.items.each do |item|
        expect(item.infected?).to be_truthy
      end
    end
  end
end
