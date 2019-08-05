# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: 'Item' do
    name { Faker::Name.first_name }
    points_value { Faker::Number.between(from: 1, to: 4) }
    image_url { Faker::LoremPixel.image(size: '40x40').to_s + '.jpg' }
  end
end
