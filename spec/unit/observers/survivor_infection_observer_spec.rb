# frozen_string_literal: true

RSpec.describe SurvivorInfectionObserver do
  before :each do
    @survivor = create(:survivor, :with_inventory)
    @observer = SurvivorInfectionObserver.instance
  end

  it 'should invoke after_update on the observed object' do
    expect(@survivor).to receive(:saved_change_to_infected?)
    @observer.after_update(@survivor)
  end
end
