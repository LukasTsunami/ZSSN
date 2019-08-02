# frozen_string_literal: true

# At zombie apocalipse everyone who is alive is an survivor
class Survivor < ApplicationRecord
  has_many :inventory
  has_many :items, through: :inventory
end
