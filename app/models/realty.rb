class Realty < ActiveRecord::Base
  validates :reference, length: {maximum: 255}
end
