# frozen_string_literal: true

require 'active_model'

# Extracts all validating business rules of Item
class ItemValidator < SimpleDelegator
  include ActiveModel::Validations

  validates :name, presence: true, format: { with: /\A[a-z A-Z]+\z/, message: 'only allows letters' }
  validates :points_value, presence: true, inclusion: { in: 1..4 }
  validate :image_url?
  validate :allowed_image_format?

  # The most important thing to use validator as a separated class
  def validate(item)
    __setobj__(item)
    super

    item.errors.messages.merge!(errors.messages)
  end

  private

  def image_url?
    return if image_url.nil?
    return if image_url =~ /^#{URI::DEFAULT_PARSER.make_regexp}$/

    errors.add(:image_url, 'Please provide a valid image url')
  end

  def allowed_image_format?
    return true if image_url.nil?
    return true if image_url =~ /\.(png|jpg|gif|bmp|svg)\Z/i

    errors.add(:image_url, 'Please provide image in one of this formats: png|jpg|gif|bmp|svg')
  end
end
