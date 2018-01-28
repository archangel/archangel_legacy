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

Deploy a sample application to [Heroku](https://www.heroku.com/) to play with.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/archangel/sample)

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

[Travis CI](https://travis-ci.org/) is used for running tests. To get the best possible overview of issues with different Ruby versions, Archangel is tested with multiple various of Ruby. See `.travis.yml` for the versions of Ruby tested.

[Hound](https://houndci.com/) is used as the code analyzer. When making a pull request, you may get comments on style and quality violations.

### Brakeman

[Brakeman](https://github.com/presidentbeef/brakeman) is a static analysis security vulnerability scanner.

```
$ brakeman
```

### RuboCop

[RuboCop](https://github.com/bbatsov/rubocop) is a Ruby static code analyzer.

```
$ rubocop
```

### scss-lint

[scss-lint](https://github.com/brigade/scss-lint) is a SCSS style analyzer.

```
$ scss-lint .
```

## Documentation

[Online documentation is available](http://www.rubydoc.info/github/archangel/archangel/master)

[Yard](https://github.com/lsegal/yard) is used to generate documentation.

Build the documentation

```
$ yard
```

or

```
$ yard doc
```

Build the documentation and list all undocumented objects

```
$ yard stats --list-undoc
```

## Developers

- TODO: Archangel gem development instructions and resources
- TODO: Archangel instructions and resources for theme developers
- TODO: Archangel instructions and resources for extension developers

## Contributing

1.  Fork it ([https://github.com/archangel/archangel/fork](https://github.com/archangel/archangel/fork))
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request
