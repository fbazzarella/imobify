class Realty < ActiveRecord::Base
  belongs_to :city

  validates :reference, length: {maximum: 255}
end
