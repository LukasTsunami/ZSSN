# frozen_string_literal: true

FactoryBot.define do
  factory :survivor, class: 'Survivor' do
    name { Faker::Name.first_name }
    age { Faker::Number.between(from: 16, to: 70) }
    gender { Faker::Gender.binary_type }
    latitude { Faker::Address.latitude.round(6) }
    longitude { Faker::Address.longitude.round(6) }
    infected { false }
  end

  trait :with_inventory do
    after :create do |survivor|
      survivor.inventory << FactoryBot.create(:inventory, survivor: survivor)
    end
  end
end
