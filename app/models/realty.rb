class Realty < ActiveRecord::Base
  BUSINESS_KIND = %w(sale rental vacation_rental)
  REALTY_KIND   = %w(house apartment kitchenette room store terrain country_house site farm)

  NUMERIC_FIELDS   = %i(rooms bathrooms parking_spaces size price taxes)
  TEXT_FIELDS      = %i(neighborhood street business_kind realty_kind reference)
  PERMITTED_FIELDS = NUMERIC_FIELDS + TEXT_FIELDS + %i(country_id city_id description published)

  belongs_to :country
  belongs_to :city

  has_many :photos, dependent: :destroy

  validates :country_id, :city_id, presence: true

  validates :business_kind, inclusion: BUSINESS_KIND, allow_nil: true
  validates :realty_kind,   inclusion: REALTY_KIND,   allow_nil: true

  validates *NUMERIC_FIELDS, numericality: {only_integer: true}, allow_nil: true

  validates *TEXT_FIELDS, length: {maximum: 255}

  def self.new_with_last_locations
    any? ? new(last.attributes.extract!('country_id', 'city_id')) : new
  end

  def locations
    Country.all_with_cities_by(country)
  end
end
