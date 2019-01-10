My Land's End to John O Groats tracker.
.......................................





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






