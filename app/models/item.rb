# frozen_string_literal: true

# Items are things which guarantee survival
class Item < ApplicationRecord
  has_many :inventory
  has_many :survivors, through: :inventory

  validates :name, presence: true, format: { with: /\A[a-z A-Z]+\z/, message: 'only allows letters' }
  validates :points_value, presence: true, inclusion: { in: 1..4 }
  validate :image_url?
  validate :allowed_image_format?

  def image_url?
    return if image_url.nil?
    return if image_url =~ /^#{URI::DEFAULT_PARSER.make_regexp}$/
    return if allowed_image_format?

    errors.add(:image_url, 'Please provide a valid image url')
  end

  def allowed_image_format?
    return true if image_url.nil?
    return true if image_url =~ /\.(png|jpg|gif|bmp|svg)\Z/i

    errors.add(:image_url, 'Please provide image in one of this formats: png|jpg|gif|bmp|svg')
  end
end
