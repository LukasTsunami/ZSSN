# frozen_string_literal: true

require 'item'

RSpec.describe 'When marking a survivor as infected' do
  it 'should mark all its inventory items as infected too' do
    survivor = create(:survivor, :with_inventory, infected: false)
    survivor.infected = true
    survivor.save

    survivor.items.each do |item|
      expect(item.infected?).to be_truthy
    end
  end

  it 'should mark all its inventory items as infected too with observer' do
    survivor = create(:survivor, :with_inventory, infected: false)
    survivor.infected = true
    survivor.save

    survivor.items.each do |item|
      expect(item.infected?).to be_truthy
    end
  end
end
