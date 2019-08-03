# frozen_string_literal: true

require 'item'

RSpec.describe Item do
  context '#associations:' do
    it { should belong_to(:infectable) }
  end

  context 'When creating an item' do
    context 'when data is valid' do
      it 'should return a new item' do
        new_item = create(:item)
        expect(new_item).to be_valid
      end
    end
  end
end
