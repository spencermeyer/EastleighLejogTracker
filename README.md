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
LEJOGMAILTARGET environmental variable.
MAILGUNAPIKEY

TODO
----

This all works for me, but for a test user it did not.

put this in the collect job as debug information ?

https://developers.strava.com/docs/reference/#api-Athletes-getLoggedInAthlete




Write bash scripts to start up and shut down resque processes.

-Have a preferred units for a user.

NICE TO HAVE
............
Alter the map helper url from force to auto for deploy.

admin panel for start and finish dates.


before deploy:
--------------

Deploy notes
------------
Restart resque stuff  (if there were any code changes, the deploy doesn't stop the processes).

Build this on digital ocean
----------------------------

Having trouble with peer authentication
---------------------------------------
sudo -u postgres psql
SHOW hba_file;
/etc/postgresql/9.5/main/pg_hba.conf
changed local authentication to trust from peer.
pg_ctl reload

Useful debug lines
------------------
User.all.each { |user| puts user.id.to_s + '  ' + user.strava_refresh_token.to_s + '  ' + user.first_name.to_s + ' ' + user.strava_access_token.to_s};0

How to restart resque processes
-------------------------------
RAILS_ENV=production BACKGROUND=yes bundle exec rake resque:scheduler &
RAILS_ENV=production BACKGROUND=yes bundle exec rake resque_delayed:work &
RAILS_ENV=production BACKGROUND=yes QUEUE=* bundle exec rake environment resque:work &


