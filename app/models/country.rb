class Country < ActiveRecord::Base
  has_many :cities, dependent: :restrict_with_error
  has_many :realties, dependent: :restrict_with_error

  validates :initial, :name, :slug, presence: true
  validates :initial, length: {is: 2}
  validates :name, :slug, length: {maximum: 255}

  def self.all_with_cities_by(country)
    {countries: all, cities: country.cities}
  end
end
