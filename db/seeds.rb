Dir[File.expand_path('../seeds/*', __FILE__)].each { |f| require f }

def truncate_tables!
  %w(photos realties users accounts).each do |table_name|
    ActiveRecord::Base.connection.execute("delete from #{table_name}")
  end
end

if %w(development staging).include?(Rails.env)
  truncate_tables!

  User.create({
    account:   Account.create(name: 'Real Estate 1'),
    username: 'johndoe',
    password: 'secret'
  })

  20.times do |i|
    Realty.create({
      country_id:     19,
      city_id:        3652,
      business_kind:  Realty::BUSINESS_KIND.sample,
      realty_kind:    Realty::REALTY_KIND.sample,
      status:         Realty::STATUS.sample,
      reference:      rand * i,
      rooms:          rand(3),
      bathrooms:      rand(3),
      parking_spaces: rand(3),
      size:           rand(300),
      price:          rand(300) * 1000,
      taxes:          rand(300)
    })
  end
end
