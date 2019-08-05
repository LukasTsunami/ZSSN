# frozen_string_literal: true

require 'item'

RSpec.describe 'When reporting a survivor as infected' do
  context 'calling the method report_as_infected' do
    let(:survivor) { create(:survivor) }
    it 'should change reporting status from zero reportings to one' do
      expect(survivor).to transition_from(:zero_reports).to(:one_reports).on_event(:report_as_infected)
    end
    it 'should change reporting status from zero reportings to two' do
      survivor.report_as_infected
      expect(survivor).to transition_from(:one_reports).to(:two_reports).on_event(:report_as_infected)
    end
    it 'should change reporting status from zero reportings to three' do
      survivor.report_as_infected
      survivor.report_as_infected
      expect(survivor).to transition_from(:two_reports).to(:three_reports).on_event(:report_as_infected)
    end
  end

  context 'after the last one' do
    it 'should declare survivor as infected' do
      survivor = create(:survivor, :with_query_inventory, infected: false)
      survivor.report_as_infected
      survivor.report_as_infected
      survivor.report_as_infected
      expect(survivor.infected?).to be_truthy
    end

    it 'should mark all its inventory items as infected too' do
      survivor = create(:survivor, :with_query_inventory, infected: false)
      survivor.infected = true
      survivor.save

      survivor.items.each do |item|
        expect(item.infected?).to be_truthy
      end
    end
  end
end
