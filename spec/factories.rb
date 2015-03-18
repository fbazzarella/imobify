FactoryGirl.define do
  factory :account do
    name  'Real Estate'
    phone '555 1111'
    email 'john@doe.com'
  end

  factory :site_setting do
    account
    title    'Real Estate'
    logo     'logo_sample_1.jpg'
    template 'zoner'
  end

  factory :domain do
    account

    sequence :host do |n|
      "#{n}.lvh.me"
    end
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
    account
    country
    city
  end

  factory :photo do
    realty
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/photo.gif')))
  end
end
