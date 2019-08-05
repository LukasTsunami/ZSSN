# frozen_string_literal: true

# Items are things which guarantee survival
class Item < ApplicationRecord
  has_many :inventory
  has_many :survivors, through: :inventory

  validates_with ItemValidator
end
