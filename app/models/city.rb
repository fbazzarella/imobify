class City < ActiveRecord::Base
  belongs_to :country

  has_many :realties, dependent: :restrict_with_error
  
  validates :name, :slug, presence: true
  validates :name, :slug, length: {maximum: 255}
end