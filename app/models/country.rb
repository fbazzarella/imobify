class Country < ActiveRecord::Base
  has_many :cities, dependent: :restrict_with_error

  validates :initial, :name, :slug, presence: true
  validates :initial,     length: {is: 2}
  validates :name, :slug, length: {maximum: 255}
end
