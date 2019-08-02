# frozen_string_literal: true

class Item < ApplicationRecord
    has_many :inventory
    has_many :survivors, through: :inventory
end
