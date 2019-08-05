# frozen_string_literal: true

# At zombie apocalipse everyone who is alive is an survivor
class Survivor < ApplicationRecord
  include InfectionReportStateMachineConcern
  has_many :inventory, -> { readonly }, class_name: QueryInventory.to_s
  has_many :items, through: :inventory

  validates_with SurvivorValidator
end
