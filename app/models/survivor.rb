# frozen_string_literal: true

# At zombie apocalipse everyone who is alive is an survivor
class Survivor < ApplicationRecord
  include InfectionReportStateMachine

  has_many :inventory
  has_many :items, through: :inventory

  validates :name, presence: true, format: { with: /\A[a-z A-Z]+\z/, message: 'only allows letters' }
  validates :age, presence: true
  validates :gender, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  validates :age, inclusion: { in: 10..100 }
  validate :should_be_male_or_female?
  validates_numericality_of :latitude
  validates_numericality_of :longitude
  validate :valid_latitude?
  validate :valid_longitude?

  def valid_latitude?
    return if six_digits_precision?(latitude) && (latitude.is_a? Numeric)

    errors.add(:latitude, 'Please provide a float number for latitude coordinates with six precision digits')
  end
  
  def valid_longitude?
    return if six_digits_precision?(longitude) && (longitude.is_a? Numeric)
    
    errors.add(:longitude, 'Please provide a float number for longitude coordinates with six precision digits')
  end

  def six_digits_precision?(number)
    parts = number.to_s.split('.')
    return false if parts.size != 2
    return parts.last.size === 6
  end

  def should_be_male_or_female?
    return if %w[male female].include? gender.to_s.downcase

    errors.add(:gender, 'Please provide a valid gender [male or female]')
  end
end
