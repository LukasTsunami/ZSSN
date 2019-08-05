# frozen_string_literal: true

# Every survivor has an inventory
# which could have or not items,
# tradable between survivors
class QueryInventory < Inventory
  before_update :be_immutable!

  protected 
  
  def be_immutable!
    false
  end
end
