# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(email: 'elvis@somewhere.com', strava_id: 1234, first_name: 'elvis', last_name: 'presley', screen_name: 'Elvis', admin: false, password: 'password')
user2 = User.create(email: 'micket@mouse.com', strava_id: 1235, first_name: 'mickey', last_name: 'mouse', screen_name: 'MickeyMouse', admin: false, password: 'password')
user3 = User.create(email: 'minnie@mouse.com', strava_id: 1236, first_name: 'minnie', last_name: 'mouse', screen_name: 'MinnieMouse', admin: false, password: 'password')

run1 = Run.create(strava_run_id: 100000000, distance: 133, user_id: user1.id)
run1 = Run.create(strava_run_id: 100000001, distance: 144, user_id: user2.id)
run1 = Run.create(strava_run_id: 100000002, distance: 155, user_id: user3.id)
run1 = Run.create(strava_run_id: 100000003, distance: 166, user_id: user1.id)
run1 = Run.create(strava_run_id: 100000004, distance: 177, user_id: user2.id)
run1 = Run.create(strava_run_id: 100000005, distance: 177, user_id: user3.id)
run1 = Run.create(strava_run_id: 100000006, distance: 177, user_id: user1.id)
run1 = Run.create(strava_run_id: 100000007, distance: 177, user_id: user2.id)





