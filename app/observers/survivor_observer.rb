# frozen_string_literal: true

# It observes survivor for infection status
# When it gets infected, it notify subscribers
class SurvivorObserver < Everett::Observer
  def after_update(survivor)
    infect_inventory(survivor) if survivor.saved_change_to_infected?
  end

  def infect_inventory(survivor)
    return unless survivor.infected?

    survivor.items.each do |item|
      item.infected = true
    end
  end
end
