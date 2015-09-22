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

User.create!(name:  "Radokiano",
             email: "examplepro@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now,pro: 1)

users = User.order(:created_at).take(8)
usera= users[0..2]
userb=users[3..7]
userpeq=users[1]
userpeqe=users[2]
usertodos= User.all.order(:created_at)
userultimo=usertodos[11]

evento = "Valencia - Granada"
pronostico= "Valencia 2 goles o +"
deporte= "futbol"
categoria= "Liga BBVA"
bookie="bet365"
cuota=1.66
stake=5
users.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                                       pickdate: "2015-09-25 20:30:00".to_time) }

evento = "Mirandes - Elche"
pronostico= "Gana Elche"
deporte= "futbol"
categoria= "Liga Adelante"
bookie="bet365"
cuota=3
stake=3
users.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                                       status:'ticked', result: 'ok', pickdate: "2015-09-10 21:00:00".to_time) }

evento = "GP Singapur"
pronostico= "Gana Hamilton"
deporte= "f1a"
categoria= "F1 Campeonato"
bookie="bet365"
cuota=2.75
stake=3
users.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                                       status:'ticked', result: 'fail', pickdate: "2015-09-11 14:00:00".to_time) }

  evento = "Celta - Barcelona"
  pronostico= "Gana Barcelona"
  deporte= "futbol"
  categoria= "Liga BBVA"
  bookie="bet365"
  cuota=1.50
  stake=5
  usera.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
  pickdate: "2015-09-23 21:00:00".to_time) }



  evento = "Nadal - Murray"
  pronostico= "Gana Nadal"
  deporte= "tenis"
  categoria= "Masters China"
  bookie="bet365"
  cuota=3
  stake=2
  userb.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                                         pickdate: "2015-10-10 10:00:00".to_time) }


evento = "Carrera en Ruta"
pronostico= "Ganador: Alejandro Valverde"
deporte= "ciclismo"
categoria= "Mundial UCI Richmond"
bookie="bet365"
cuota=23
stake=1
userb.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                                       pickdate: "2015-09-27 15:00:00".to_time) }
userultimo.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                       pickdate: "2015-09-26 20:45:00".to_time)

evento = "SA Spurs - LA Lakers"
pronostico= "Mas de 200 puntos"
deporte= "baloncesto"
categoria= "NBA"
bookie="bet365"
cuota=1.83
stake=4
usera.each { |user| user.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                                       pickdate: "2015-09-27 01:00:00".to_time) }


evento = "Etapa 19"
pronostico= "Gana Purito"
deporte= "ciclismo"
categoria= "La Vuelta"
bookie="bet365"
cuota=2.8
stake=3
userpeq.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                                       pickdate: "2015-09-27 17:00:00".to_time)

evento = "Barça - Madrid"
pronostico= "Messi anota 2 o + goles"
deporte= "futbol"
categoria= "Champions League"
bookie="bet365"
cuota=2.95
stake=3
userpeqe.picks.create!(evento: evento, pronostico: pronostico, cuota: cuota, stake: stake, deporte: deporte, categoria: categoria, bookie: bookie,
                       pickdate: "2015-09-26 20:45:00".to_time)





users[2].stats.create!( acierto: 2,
                        yield: 33,
                        acertadas: 20,
                        falladas: 5,
                        anuladas: 5,
                        totalpicks: 30,
                        profit: 10,
                        totalstaked: 30,
                        cuotaavg: 1.58,
                        totalcuota: 47.4,
                        created_at: "2015-08-03 10:30:14".to_time)

users[0].stats.create!( acierto: 66,
                        yield: 33,
                        acertadas: 20,
                        falladas: 5,
                        anuladas: 5,
                        totalpicks: 30,
                        profit: 10,
                        totalstaked: 30,
                        cuotaavg: 2,
                        totalcuota: 60,
                        created_at: "2015-08-03 10:30:14".to_time)

users[1].stats.create!( acierto: 50,
                        yield: 0,
                        acertadas: 20,
                        falladas: 20,
                        anuladas: 0,
                        totalpicks: 40,
                        profit: 0,
                        totalstaked: 80,
                        cuotaavg: 2,
                        totalcuota: 80,
                        created_at: "2015-08-03 10:30:14".to_time)

users[3].stats.create!( acierto: 60,
                        yield: 15,
                        acertadas: 19,
                        falladas: 7,
                        anuladas: 4,
                        totalpicks: 30,
                        profit: 4,
                        totalstaked: 60,
                        cuotaavg: 2,
                        totalcuota: 60,
                        created_at: "2015-08-03 10:30:14".to_time)


users[4].stats.create!( acierto: 40,
                        yield: 5,
                        acertadas: 20,
                        falladas: 5,
                        anuladas: 5,
                        totalpicks: 30,
                        profit: 10,
                        totalstaked: 30,
                        cuotaavg: 2,
                        totalcuota: 60,
                        created_at: "2015-08-03 10:30:14".to_time)

users[5].stats.create!( acierto: 50,
                        yield: 2,
                        acertadas: 20,
                        falladas: 20,
                        anuladas: 0,
                        totalpicks: 40,
                        profit: 0,
                        totalstaked: 80,
                        cuotaavg: 2,
                        totalcuota: 80,
                        created_at: "2015-08-03 10:30:14".to_time)

users[1].stats.create!( acierto: 66,
yield: 33,
acertadas: 20,
falladas: 5,
anuladas: 5,
totalpicks: 30,
profit: 10,
totalstaked: 30,
cuotaavg: 2,
totalcuota: 60,
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
                        totalcuota: 80,
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
                        totalcuota: 60,
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
                        totalcuota: 60,
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
                        totalcuota: 80,
                        created_at: "2015-09-03 10:30:14".to_time)

users[0].stats.create!( acierto: 66,
                        yield: 33,
                        acertadas: 20,
                        falladas: 5,
                        anuladas: 5,
                        totalpicks: 30,
                        profit: 10,
                        totalstaked: 30,
                        cuotaavg: 2,
                        totalcuota: 60,
                        created_at: "2015-09-03 10:30:14".to_time)

usertodos[11].stats.create!( acierto: 50,
                        yield: 2,
                        acertadas: 20,
                        falladas: 20,
                        anuladas: 0,
                        totalpicks: 40,
                        profit: 0,
                        totalstaked: 80,
                        cuotaavg: 2,
                        totalcuota: 80,
                        created_at: "2015-09-03 10:30:14".to_time)


# Following relationships
users = User.all
user  = users.first
usera = users[1]
userb = users[2]
following = users[3..7]
followers = users[3..10]
following.each { |followed| user.follow(followed)
usera.follow(followed)
userb.follow(followed)}
followers.each { |follower|
follower.follow(usera)
follower.follow(userb)}

#Favoritos por defecto
picks = Pick.all.order(:created_at)
picksfaved = picks[2]
picksfavede = picks[10]
picksfavedee = picks[18]

user.fav(picksfaved)
user.fav(picksfavede)
user.fav(picksfavedee)
