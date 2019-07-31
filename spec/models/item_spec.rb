# frozen_string_literal: true

RSpec.describe Item do
  context 'When creating an item' do
    context 'when data is valid' do
      it 'should return a new item' do
        new_item = create(:item)
        expect(new_item).to be_valid
      end
    end
  end
end
