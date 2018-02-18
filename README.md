# Archangel

** Archangel is currently under development. It is not ready for production use. **

[![Travis CI](https://travis-ci.org/archangel/archangel.svg?branch=master)](https://travis-ci.org/archangel/archangel)
[![Coverage Status](https://coveralls.io/repos/github/archangel/archangel/badge.svg?branch=master)](https://coveralls.io/github/archangel/archangel?branch=master)
[![Code Climate](https://codeclimate.com/github/archangel/archangel/badges/gpa.svg)](https://codeclimate.com/github/archangel/archangel)
[![Dependency Status](https://gemnasium.com/badges/github.com/archangel/archangel.svg)](https://gemnasium.com/github.com/archangel/archangel)
[![Inline docs](http://inch-ci.org/github/archangel/archangel.svg?branch=master)](http://inch-ci.org/github/archangel/archangel)

![Archangel](archangel.png "Archangel")

Archangel is a Rails CMS.

The Archangel logo is made by [Joshua Boyd](http://www.joshadamboyd.com/)

This project rocks and uses MIT-LICENSE.

[Online documentation is available](http://www.rubydoc.info/github/archangel/archangel/master)

## Deploying to Heroku

Deploy a sample application to [Heroku](https://www.heroku.com/) to play with.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/archangel/sample)

## Requirements

* Ruby >= 2.2.9
* Rails ~> 5.1.4

## Installation

Add to your application's Gemfile

```
gem "archangel"
```

Run the bundle command

```
$ bundle install
```

Run the install generator

```
$ bundle exec rails g archangel:install
```

Run the install generator with seed data

```
$ bundle exec rails g archangel:install --seed
```

Seed data can be created separately by running `rake db:seed`

## Updating

Subsequent updates can be done by bumping the version in your application Gemfile, then installing new migrations

```
$ bundle exec rake archangel:install:migrations
```

Run migrations

```
$ bundle exec rake db:migrate
```

## Testing

Generate a dummy application. You will be required to generate a dummy application before running tests.

```
$ bundle exec rake dummy_app
```

Run tests

```
$ bundle exec rake
```

or

```
$ bundle exec rake spec
```

or

```
$ bundle exec rspec spec
```

You can also enable fail fast in order to stop tests at the first failure

```
$ bundle exec rspec spec --fail-fast
```

## Code Analysis

* [Travis CI](https://travis-ci.org/) is used for running tests.
* [Hound](https://houndci.com/) is used as the code analyzer in pull request.

## Developers

* TODO: Archangel gem development instructions and resources
* TODO: Archangel instructions and resources for theme developers
* TODO: Archangel instructions and resources for extension developers

## Contributing

A [contributing guide](CONTRIBUTING.md) is available.

1. Fork it ([https://github.com/archangel/archangel/fork](https://github.com/archangel/archangel/fork))
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
