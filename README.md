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
Make a job to refresh access tokens continually...
Alter the map helper url from force to auto for deploy.

FINISH THE COLLECT USER DATA JOB, DEPENDS ON THE RUN MODEL.

MAKE THE TOTALIZER WORK  (selector, sort by, total_miles method.)
Make the leaderboard work correctly.
DISTANCE CONVERTER
remove strava run id from views after testing
add a disabled button if the stava id is not entered



