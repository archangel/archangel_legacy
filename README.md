# Archangel

**Archangel is currently under development. It is not ready for production use.**

[![Travis CI](https://travis-ci.org/archangel/archangel.svg?branch=master)](https://travis-ci.org/archangel/archangel)
[![Coverage Status](https://coveralls.io/repos/github/archangel/archangel/badge.svg?branch=master)](https://coveralls.io/github/archangel/archangel?branch=master)
[![Code Climate](https://codeclimate.com/github/archangel/archangel/badges/gpa.svg)](https://codeclimate.com/github/archangel/archangel)
[![Dependency Status](https://gemnasium.com/badges/github.com/archangel/archangel.svg)](https://gemnasium.com/github.com/archangel/archangel)
[![Inline docs](http://inch-ci.org/github/archangel/archangel.svg?branch=master)](http://inch-ci.org/github/archangel/archangel)

This project rocks and uses MIT-LICENSE.


## Requirements

- Ruby >= 2.2.3
- Rails ~> 5.1.4

## Deploying to Heroku

Deploy a sample application to play with.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/archangel/sample)

## Installation

Add to your application's Gemfile

```
gem "archangel", github: "archangel/archangel"
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

Subsequent updates can be done by bumping the version in your Gemfile then adding the new migrations

```
$ bundle exec rake archangel:install:migrations
```

Run migrations

```
$ bundle exec rake db:migrate
```

## Testing

A database is needed to run tests. Drop the existing test database, create it and run migrations.

```
$ bundle exec rails app:db:reset
$ bundle exec rails app:db:migrate
```

Run tests

```
$ bundle exec rake
```

This is the same command that gets run for CI

```
$ bundle exec rake test
```

## Code Analysis

[Hound](https://houndci.com/) is used as the code analyzer. When making a pull request, you may get comments on style and quality violations.

### Reek

[Reek](https://github.com/troessner/reek) is a code smell detector for Ruby.

```
$ reek
```

### RuboCop

[RuboCop](https://github.com/bbatsov/rubocop) is a Ruby static code analyzer.

```
$ rubocop
```

### Brakeman

[Brakeman](https://github.com/presidentbeef/brakeman) is a static analysis security vulnerability scanner.

```
$ brakeman
```

### scss-lint

[scss-lint](https://github.com/brigade/scss-lint) is a SCSS style analyzer.

```
$ scss-lint .
```

## Contributing

1.  Fork it ([https://github.com/archangel/archangel/fork](https://github.com/archangel/archangel/fork))
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request
