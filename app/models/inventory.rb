# frozen_string_literal: true

# Every survivor has an inventory
# which could have or not items,
# tradable between survivors
class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :survivor
end
