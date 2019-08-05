# frozen_string_literal: true

# Every survivor has an inventory
# which could have or not items,
# tradable between survivors
class QueryInventory < ApplicationRecord
  self.table_name = 'inventory'

  belongs_to :item
  belongs_to :survivor

  before_update :be_immutable!

  def be_immutable!
    return false
  end
end
