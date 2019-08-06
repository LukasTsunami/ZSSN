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
        
        it 'should be a valid image' do  
          image = create(:item)
          expect(image.image_url).to match(/\.(png|jpg|gif|bmp|svg)\Z/i)
        end
        it 'should be a valid url' do  
          image = create(:item)
          expect(image.image_url).to match(/^#{URI::DEFAULT_PARSER.make_regexp}$/)
        end
        it 'should be an invalid image, but valid url' do  
          custom_image_url = 'http://www.site.com/imagems'
          expect { create(:item, image_url: custom_image_url) }.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Image url Please provide image in one of this formats: png|jpg|gif|bmp|svg')
        end
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
