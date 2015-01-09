class Realty < ActiveRecord::Base
  belongs_to :city

  validates :city_id, presence: true
  validates :reference, length: {maximum: 255}
end
