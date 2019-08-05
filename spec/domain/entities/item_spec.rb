# frozen_string_literal: true

require 'item'

RSpec.describe Item, type: :model do
  context 'When creating an item' do
    context 'when validating' do
      describe '#name' do
        it { should validate_presence_of(:name) }
        it { should_not allow_value(123).for(:name) }
        it { should_not allow_value('almost@there.com').for(:name) }
        it { should allow_value('Lucas').for(:name) }
        it { should allow_value('Jon Tron').for(:name) }
      end

      describe '#points_value' do
        it { should validate_presence_of(:points_value) }
        it { should validate_inclusion_of(:points_value).in_range(1..4) }
      end

      # Its an optional field
      describe '#image_url' do
        it { should_not allow_value(123).for(:image_url) }
        it { should_not allow_value('almost@there.com').for(:image_url) }
        it { should allow_value('http://www.site.com/imagem.jpg').for(:image_url) }
        it { should allow_value('./imagem.png').for(:image_url) }
      end
    end

    context 'when data is valid' do
      it 'should return a new item' do
        new_item = create(:item)
        expect(new_item).to be_valid
      end
    end
  end
end
