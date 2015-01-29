Dir[File.expand_path('../seeds/*', __FILE__)].each { |f| require f }

if %w(development staging).include?(Rails.env)
  User.destroy_all
  Realty.destroy_all

  User.create({
    username: 'johndoe',
    password: 'secret'
  })

  5.times do |i|
    Realty.create({
      country_id:     19,
      city_id:        3652,
      business_kind:  %w(sale rental).sample,
      realty_kind:    %w(house apartment).sample,
      status:         %w(published scratch).sample,
      reference:      rand * i,
      rooms:          rand(3),
      bathrooms:      rand(2),
      parking_spaces: rand(1),
      size:           rand(300),
      price:          rand(200) * 1000,
      taxes:          rand(100)
    })
  end
end
