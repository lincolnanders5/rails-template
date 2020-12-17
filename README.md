# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization
```shell
pg_ctl -D db/data/ init                       # Initialize database 
pg_ctl -D db/data/ -l log/pg.log start        # Start up database
bin/rails db:create                           # Create database

rails generate devise:install
rails generate devise user

rails generate migration add_name_to_users \
  username:string \
  given_name:string family_name:string

pg_ctl -D db/data/ stop                       # Stop database
```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
