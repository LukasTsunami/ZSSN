# frozen_string_literal: true

RSpec.describe Survivor, type: :model do
  describe 'Creating a new survivor' do
    context 'when validating' do
      describe '#name' do
        it { should validate_presence_of(:name) }
        it { should_not allow_value(123).for(:name) }
        it { should_not allow_value('almost@there.com').for(:name) }
        it { should allow_value('Lucas').for(:name) }
        it { should allow_value('Jon Tron').for(:name) }
      end

      describe '#age' do
        it { should validate_presence_of(:age) }
        it { should validate_inclusion_of(:age).in_range(10..100) }
      end

      describe '#gender' do
        it { should validate_presence_of(:gender) }
        it { should validate_inclusion_of(:gender).in_array(%w[male female]).with_message('Please provide a valid gender [male or female]') }
      end

      describe '#latitude' do
        it { should validate_presence_of(:latitude) }
        it { should validate_numericality_of(:latitude) }
        it { should_not allow_value(123).for(:latitude) }
        it { should_not allow_value('almost@there.com').for(:latitude) }

        # it should allow only values with six digits of decimal precision
        it { should allow_value(10.101245).for(:latitude) }
      end

      describe '#longitude' do
        it { should validate_presence_of(:longitude) }
        it { should validate_numericality_of(:longitude) }
        it { should_not allow_value(123).for(:longitude) }
        it { should_not allow_value('almost@there.com').for(:longitude) }

        # it should allow only values with six digits of decimal precision
        it { should allow_value(10.101245).for(:longitude) }
      end
    end

    context 'when data is valid' do
      let(:survivor) { create(:survivor, :with_query_inventory) }

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
end
