# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  User.destroy_all
  Realty.destroy_all
  
  User.create({
    username: 'johndoe',
    password: 'secret'
  })

  10.times do |i|
    Realty.create({
      reference: "key#{i*123}"
    })
  end
end
