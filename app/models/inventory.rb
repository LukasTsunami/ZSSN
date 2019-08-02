# frozen_string_literal: true

class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :survivor
end
