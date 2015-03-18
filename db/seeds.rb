Dir[File.expand_path('../seeds/*', __FILE__)].each { |f| require f }

def truncate_tables!
  %w(photos realties users domains site_settings accounts).each do |table_name|
    ActiveRecord::Base.connection.execute("delete from #{table_name}")
  end
end

def realty_params
  {
    country_id:     19,
    city_id:        3652,
    business_kind:  Realty::BUSINESS_KIND.sample,
    realty_kind:    Realty::REALTY_KIND.sample,
    status:         'published', # Realty::STATUS.sample,
    reference:      rand,
    rooms:          rand(3),
    bathrooms:      rand(3),
    parking_spaces: rand(3),
    size:           rand(300),
    price:          rand(300) * 1000,
    taxes:          rand(300)
  }
end

if %w(development staging).include?(Rails.env)
  truncate_tables!

  account1 = Account.create({
    name:  'John Doe Real Estate, Inc',
    phone: '(21) 2255-1111',
    email: 'john@doe.com'
  })

  account2 = Account.create({
    name:  'Jane Doe Real Estate, Co',
    phone: '(21) 2255-2222',
    email: 'jane@doe.com'
  })

  SiteSetting.create({
    account:  account1,
    title:    'John Doe Real Estate',
    logo:     'logo_johndoe.jpg',
    template: 'zoner'
  })

  SiteSetting.create({
    account:  account2,
    title:    'Jane Doe Real Estate',
    logo:     'logo_janedoe.jpg',
    template: 'zoner'
  })

  Domain.create(account: account1, host: 'johndoe.lvh.me')
  Domain.create(account: account2, host: 'janedoe.lvh.me')

  Domain.create(account: account1, host: 'johndoe.staging.imobify.com.br')
  Domain.create(account: account2, host: 'janedoe.staging.imobify.com.br')

  ActsAsTenant.with_tenant account1 do
    User.create(username: 'johndoe', password: 'secret')
    8.times { Realty.create(realty_params) }
  end

  ActsAsTenant.with_tenant account2 do
    User.create(username: 'janedoe', password: 'secret')
    8.times { Realty.create(realty_params) }
  end
end
