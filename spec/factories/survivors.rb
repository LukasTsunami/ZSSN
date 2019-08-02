# frozen_string_literal: true

FactoryBot.define do
  factory :survivor, class: 'Survivor' do
    name { Faker::Name.first_name }
    age { Faker::Number.between(from: 16, to: 70) }
    gender { Faker::Gender.binary_type }
    latitude { Faker::Address.latitude  }
    longitude { Faker::Address.longitude }
    infected { :not_infected }
  end
end
