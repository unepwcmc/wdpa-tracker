# WDPA Tracker

An application that tracks the evolution of the WDPA (World Database of Protected Areas)

## Installation

This is a simple Rails app, with a Postgres database. Proceed with the usual:

```
$ git clone git@github.com:unepwcmc/wdpa-tracker.git
$ cd wdpa-tracker
$ cp .env.example .env && edit(or vim) .env
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ rake bower:install
$ npm install
...
$ bundle exec rails server
```

And visit http://localhost:3000! 🎉
