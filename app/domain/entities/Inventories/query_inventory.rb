# frozen_string_literal: true

# Every survivor has an inventory
# which could have or not items,
# tradable between survivors
class QueryInventory < Inventory
  before_update :be_immutable!

  validates :amount, presence: true
  validates :survivor, presence: true
  validates :item, presence: true

  protected 

  def be_immutable!
    false
  end
end
