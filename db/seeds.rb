# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Ricardo",
             email: "mejiaro@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!( name: "Cristina Ramirez",
              email: "lamermeow@gmail.com",
              password:              "foobar",
              password_confirmation: "foobar",
              activated: true,
              activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password:      password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
              
end

users = User.order(:created_at).take(7)
lengths = [5,6,7]
50.times do
  content = Faker::Lorem.sentence(lengths.sample)
  users.each { |user| user.microposts.create!(content: content)}
end