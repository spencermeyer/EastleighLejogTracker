My Land's End to John O Groats tracker.
.......................................

This app allows users to track their virtual progress from Land's end to John O Groats on a google map. 

I'm using Ruby on rails for the app, and the front end employs some React jsx for the map view. 

Ruby 2.4.0
Rails 5.1.6
Postgresql.
Resque (for background jobs).

Services running are:
Resque, resque worker, resque scheduler.

The strava auth controller stores athlete authorisation tokens and athlete refresh tokens in the users table.  
There is a refresh tokens job that queues a refresh token jon for each user at 10 second intervals.

I use the strava webhook.  This posts data to this application when a signed up user creates a run.  It then uses the strava data API to populate the data for that run.

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
STRAVA_VERIFY_TOKEN for the webhook.

I had a silent failure of webpacker for a long time, and found that adding 1G of swap memory fixed this.

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

and this is what it should look like when started up:
deploy    1786  0.0  8.4 334684 86112 ?        Sl   09:49   0:00 resque-1.27.4: Waiting for collect
deploy    1799  0.0  7.0 247444 72088 ?        Sl   09:49   0:00 resque-scheduler-4.3.1[production]: Schedules Loaded
deploy    1803 68.3  7.0 242620 72060 pts/0    Sl   09:49   0:02 resque-delayed: harvesting


Only works for one user
-----------------------

Failed Collect Data Job for Paul

Error code: 401
{"message":"Authorization Error","errors":[{"resource":"Athlete","field":"access_token","code":"invalid"}]}

Documentation Sources
.....................
There were a lot of http requests (at least initially).  This is good reference:
https://www.rubyguides.com/2018/08/ruby-http-request/

Here is the documentation on strava's webhooks:
http://developers.strava.com/docs/webhooks/


Here could be the thing:

https://groups.google.com/forum/#!topic/strava-api/Ah_jbfZ_G-o

So the GET Api does not allow pulling of other athletes data. BUT . . . 

ACTUALLY, THE WEBHOOK MAY DO WHAT I WANT BETTER.
................................................














