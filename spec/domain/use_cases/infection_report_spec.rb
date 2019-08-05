# frozen_string_literal: true

RSpec.describe 'When someone reports a survivor as infected' do
  context 'check how many times he/she has been reported' do
    let(:survivor) { create(:survivor) }

    it 'if #zero should change reporting status to one' do
      expect(survivor).to transition_from(:zero_reports).to(:one_reports).on_event(:report_as_infected)
    end

    it 'if #one should change reporting status to two' do
      survivor.report_as_infected
      expect(survivor).to transition_from(:one_reports).to(:two_reports).on_event(:report_as_infected)
    end

    context 'if #three' do
      it 'should change reporting status to three' do
        survivor.report_as_infected
        survivor.report_as_infected
        expect(survivor).to transition_from(:two_reports).to(:three_reports).on_event(:report_as_infected)
      end

      it 'should declare survivor as infected' do
        survivor = create(:survivor, :with_query_inventory, infected: false)
        survivor.report_as_infected
        survivor.report_as_infected
        survivor.report_as_infected
        expect(survivor.infected?).to be_truthy
      end
    end
  end
end
