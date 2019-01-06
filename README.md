My Land's End to John O Groats tracker.
.......................................




Ruby 2.4.0
Rails 5.1.6
Postgresql.


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...





Build Log
---------

First shot at the jsx map, and there was a performance issue with the map.
Reduced the size of the gpx file at https://labs.easyblog.it/maps/gpx-simplify-optimizer/


How to start a resque worker:
QUEUE='*' bundle exec rake environment resque:work
rake resque:scheduler
bundle exec rake environment resque_delayed:work QUEUE='*'





