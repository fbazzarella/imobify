class Realty < ActiveRecord::Base
  belongs_to :country
  belongs_to :city

  validates :country_id, :city_id, presence: true
  validates :rooms, :bathrooms, :parking_spaces, numericality: {only_integer: true}, allow_nil: true
  validates :size, :price, :taxes, numericality: true, allow_nil: true
  validates :reference, :neighborhood, :street, :business_kind, :realty_kind, length: {maximum: 255}
end
