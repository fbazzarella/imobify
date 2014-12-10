FactoryGirl.define do
  factory :user do
    username 'johndoe'
    password 'secret'
  end

  factory :realty do
    reference 'key123'
  end
end
