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
activated: true, admin: true,
             activated_at: Time.zone.now,pro: 1)

10.times do |n|
  name  = Faker::Name.name[5..15]
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password, activated: true)
end

users = User.order(:created_at).take(6)
5.times do
  evento = "Barcelona-Elche"
  pronostico= "Gana Barcelona"
  deporte= "futbol"
  categoria= "Liga BBVA"
  cuota=1.30
  stake=10
  users.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria,
  pickdate: "2015-09-15 22:00:00".to_time) }
end

5.times do
  evento = "Federer-Djokovic"
  pronostico= "Gana Federer"
  deporte= "tenis"
  categoria= "Liga BBVA"
  cuota=3
  stake=2
  users.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria,
                                         pickdate: "2015-09-10 22:00:00".to_time) }
end

5.times do
  evento = "SA Spurs - LA Lakers"
  pronostico= "Mas de 200 puntos"
  deporte= "baloncesto"
  categoria= "NBA"
  cuota=1.90
  stake=4
  users.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria,
                                         pickdate: "2015-09-09 22:00:00".to_time) }
end

users[1].stats.create!( acierto: 66,
yield: 33,
acertadas: 20,
falladas: 5,
anuladas: 5,
totalpicks: 30,
profit: 10,
totalstaked: 30,
cuotaavg: 2,
created_at: "2015-09-03 10:30:14".to_time)

users[2].stats.create!( acierto: 50,
                        yield: 0,
                        acertadas: 20,
                        falladas: 20,
                        anuladas: 0,
                        totalpicks: 40,
                        profit: 0,
                        totalstaked: 80,
                        cuotaavg: 2,
                        created_at: "2015-09-03 10:30:14".to_time)

users[3].stats.create!( acierto: 60,
                        yield: 15,
                        acertadas: 19,
                        falladas: 7,
                        anuladas: 4,
                        totalpicks: 30,
                        profit: 4,
                        totalstaked: 60,
                        cuotaavg: 2,
                        created_at: "2015-09-03 10:30:14".to_time)


users[4].stats.create!( acierto: 40,
                        yield: 5,
                        acertadas: 20,
                        falladas: 5,
                        anuladas: 5,
                        totalpicks: 30,
                        profit: 10,
                        totalstaked: 30,
                        cuotaavg: 2,
                        created_at: "2015-09-03 10:30:14".to_time)

users[5].stats.create!( acierto: 50,
                        yield: 2,
                        acertadas: 20,
                        falladas: 20,
                        anuladas: 0,
                        totalpicks: 40,
                        profit: 0,
                        totalstaked: 80,
                        cuotaavg: 2,
                        created_at: "2015-09-03 10:30:14".to_time)


# Following relationships
users = User.all
user  = users.first
following = users[2..7]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }