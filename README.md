# EA Work Club
[![Build Status](https://travis-ci.org/henryaj/ea-work-club.svg?branch=master)](https://travis-ci.org/henryaj/ea-work-club)

**High-impact jobs and side projects for effective altruists.**

## About

A basic CRUD app, with _Jobs_ (job listings at EA orgs) and _Projects_ (things EAs are working on and need help with, or just think someone should be making).

## Contributing

Check the [projects](https://github.com/henryaj/ea-work-club/projects) for work that's in progress or needs doing. Feel free to add your own feature requests!

### Setting up

1. Clone the repo locally
1. Change dir into the repo and run `bundle install`
1. Create a Postgres database called `eajobs_development` (usually with `createdb`)
1. Run any pending database migrations: `rails db:migrate`
1. Start the site with `rails s`

Currently login functionality won't work locally without Auth0 secrets; I'm working on this.

### Making changes

Please make a PR against `develop`.
