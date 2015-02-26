FactoryGirl.define do
  factory :account do
    name 'Real Estate'
  end

  factory :user do
    account
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
    country
    city
  end

  factory :photo do
    realty
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/photo.gif')))
  end
end
