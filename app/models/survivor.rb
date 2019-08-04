# frozen_string_literal: true

# At zombie apocalipse everyone who is alive is an survivor
class Survivor < ApplicationRecord
  has_many :inventory
  has_many :items, through: :inventory

  after_update :infect_inventory, if: :saved_change_to_infected?

  def infect_inventory
    return unless infected?

    items.each do |item|
      item.infected = true
    end
  end
end
