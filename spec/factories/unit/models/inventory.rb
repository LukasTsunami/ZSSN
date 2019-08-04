# frozen_string_literal: true

FactoryBot.define do
  factory :inventory do
    item { create(:item) }
    survivor { create(:survivor) }
  end
end
