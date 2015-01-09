FactoryGirl.define do
  factory :user do
    username 'johndoe'
    password 'secret'
  end

  factory :country do
    initial 'RJ'
    name    'Rio de Janeiro'
    slug    'rio-de-janeiro'
  end

  factory :city do
    country
    name      'Rio de Janeiro'
    slug      'rio-de-janeiro-rj'
    principal true
  end

  factory :realty do
    city
    reference 'key123'
  end
end
