# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
activated: true,
             activated_at: Time.zone.now)

10.times do |n|
  name  = Faker::Name.name[5..15]
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
27.times do
  evento = "Barcelona-Elche"
  pronostico= "Gana Barcelona"
  deporte= "futbol"
  categoria= "Liga BBVA"
  cuota=1.30
  stake=10
  users.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..7]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }