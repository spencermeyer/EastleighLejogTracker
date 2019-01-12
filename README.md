My Land's End to John O Groats tracker.
.......................................

This app allows users to track their virtual progress from Land's end to John O Groats on a google map. 

I'm using Ruby on rails for the app, and the front end employs some React jsx for the map view. 

Ruby 2.4.0
Rails 5.1.6
Postgresql.

Services running are:
Resque, resque worker, resque scheduler.

Build Log
---------

First shot at the jsx map, and there was a performance issue with the map.
Reduced the size of the gpx file at https://labs.easyblog.it/maps/gpx-simplify-optimizer/


How to start a resque worker:
QUEUE='*' bundle exec rake environment resque:work
rake resque:scheduler
bundle exec rake environment resque_delayed:work QUEUE='*'


General Setup
-------------
SLACK_WEBHOOK_URL environmental variable.
STRAVA_CLIENT_ID  environental variable.
STRAVA_CLIENT_SECRET environmental variable.

TODO
----


MUST DO BEFORE TESTING
......................
DISTANCE CONVERTER

remove strava run id from views after testing

sort map helper with the callback url config

MUST DO BEFORE PUT INTO WILD
............................
MAKE THE TOTALIZER WORK  (selector, sort by, total_miles method.)

Make the leaderboard work correctly.  (make it a react component?).

Put leaderboard and team tags on the route.

NICE TO HAVE
............
Alter the map helper url from force to auto for deploy.

add a message button to the FAQs.

admin panel for start and finish dates.

Make a job to refresh access tokens daily...and then refresh data.


before deploy:
--------------
admin in routes


'bugs' to fix
-------------
why when I pass a user into the resque job, does it end up as a hash and I have to look up the user again?



