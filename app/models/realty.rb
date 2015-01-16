class Realty < ActiveRecord::Base
  BUSINESS_KIND = %w(sale rental vacation_rental)
  REALTY_KIND   = %w(house apartment kitchenette room store terrain country_house site farm)

  belongs_to :country
  belongs_to :city

  validates :country_id, :city_id, presence: true

  validates :business_kind, inclusion: BUSINESS_KIND, allow_nil: true
  validates :realty_kind,   inclusion: REALTY_KIND,   allow_nil: true

  validates :reference, uniqueness: true, allow_nil: true

  validates :rooms, :bathrooms, :parking_spaces,
    :size, :price, :taxes, numericality: {only_integer: true}, allow_nil: true

  validates :reference, :neighborhood, :street, :business_kind, :realty_kind, length: {maximum: 255}
end
