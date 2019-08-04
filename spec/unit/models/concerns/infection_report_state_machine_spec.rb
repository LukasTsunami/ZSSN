# frozen_string_literal: true

# We are using shared_examples to test module behavior
RSpec.shared_examples 'an_infection_report_state_machine' do
  before(:all) do
    @class_that_includes_concern = described_class
    @intance_of_class_that_includes_concern = FactoryBot.build(@class_that_includes_concern.to_s.underscore.to_sym)
  end

  it 'should have reports states' do
    expect(@intance_of_class_that_includes_concern).to have_state :zero_reports
  end
  
  it 'should allow event report_as_infected' do
    expect(@intance_of_class_that_includes_concern).to allow_event :report_as_infected
  end
end

# In order to test Concern, we need to includes it on some model
RSpec.describe Survivor do
  it_behaves_like 'an_infection_report_state_machine'
end
