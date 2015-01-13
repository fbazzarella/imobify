class Realty < ActiveRecord::Base
  belongs_to :country
  belongs_to :city

  validates :country_id, :city_id, presence: true
  validates :reference, length: {maximum: 255}
end
