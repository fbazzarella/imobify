class RealtySearch
  include ActiveModel::Model

  attr_accessor :business_kind, :realty_kind, :city_id, :rooms, :parking_spaces

  def result
    Realty.published.by_business_kind(business_kind).by_realty_kind(realty_kind)
      .by_city_id(city_id).by_rooms(rooms).by_parking_spaces(parking_spaces)
  end
end
