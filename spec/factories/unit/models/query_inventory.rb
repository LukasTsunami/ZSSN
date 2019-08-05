# frozen_string_literal: true

FactoryBot.define do
  factory :query_inventory, class: QueryInventory do
    item { create(:item) }
    survivor { create(:survivor) }
  end
end
