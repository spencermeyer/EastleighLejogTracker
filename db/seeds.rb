# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(email: 'elvis@somewhere.com', strava_id: 1234, first_name: 'elvis', last_name: 'presley', screen_name: 'Elvis', admin: true, password: 'password')
user2 = User.create(email: 'micket@mouse.com', strava_id: 1235, first_name: 'mickey', last_name: 'mouse', screen_name: 'MickeyMouse', admin: false, password: 'password')
user3 = User.create(email: 'minnie@mouse.com', strava_id: 1236, first_name: 'minnie', last_name: 'mouse', screen_name: 'MinnieMouse', admin: false, password: 'password')

run1 = Run.create(strava_run_id: 100000000, distance: 1609*3, user_id: user1.id)
run2 = Run.create(strava_run_id: 100000001, distance: 1609*4, user_id: user2.id)
run3 = Run.create(strava_run_id: 100000002, distance: 1609*9, user_id: user3.id)
run4 = Run.create(strava_run_id: 100000003, distance: 1609*6, user_id: user1.id)
run5 = Run.create(strava_run_id: 100000004, distance: 1609*9, user_id: user2.id)
run6 = Run.create(strava_run_id: 100000005, distance: 1609*7, user_id: user3.id)
run7 = Run.create(strava_run_id: 100000006, distance: 1609*8, user_id: user1.id)
run8 = Run.create(strava_run_id: 100000007, distance: 1609*7, user_id: user2.id)





