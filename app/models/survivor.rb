class Survivor < ApplicationRecord
  has_many :inventory
  has_many :items, through: :inventory
end
