class City < ActiveRecord::Base
  belongs_to :country
  
  validates :name, :slug, presence: true
  validates :name, :slug, length: {maximum: 255}
end
