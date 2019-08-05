# frozen_string_literal: true

# It observes survivor for infection status
# When it gets infected, it notify subscribers
class SurvivorInfectionObserver < Everett::Observer
  observe :survivor

  def after_update(survivor)
    infect_inventory(survivor) if survivor.saved_change_to_infected?
  end

  # All inventory gets losed when survivor gets infected
  def infect_inventory(survivor)
    return unless survivor.infected?

    survivor.items.each do |item|
      item.infected = true
    end
  end
end
