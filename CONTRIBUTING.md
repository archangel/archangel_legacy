# Contributing to Archangel

Thanks for taking the time to contribute!

The following is a set of guidelines for contributing to Archangel and its managed extensions, which are hosted in the [Archangel Organization](https://github.com/archangel) on GitHub.

## Table Of Contents

* [Code of Conduct](#code-of-conduct)
* [How To Contribute](#how-to-contribute)
* [Issues](#issues)
* [Pull Requests](#pull-requests)
* [Testing](#code)
* [Code Analysis](#code)
* [Security and Maintenance](#security-and-maintenance)
* [Documentation](#code)

## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to
uphold this code. Please report unacceptable behavior to [archangel.cms@gmail.com](mailto:archangel.cms@gmail.com).

## How To Contribute

Help is always appreciated. If you are not able to contribute with code, bug reports are always welcome.

* [Issues](https://github.com/archangel/archangel/issues)
* [Pull Requests](https://github.com/archangel/archangel/pulls)
* [Roadmap/Milestones](https://github.com/archangel/archangel/milestones)
* [Contributors](https://github.com/archangel/archangel/graphs/contributors)

## Issues

Archangel uses [Github Issues](https://github.com/archangel/archangel/issues) to manage issues. A [number of labels](https://github.com/archangel/archangel/labels) are used to control flow and function. Enhancements and feature requests can also be submitted. Extension ideas are also accepted.

## Pull Requests

We gladly accept pull requests to Archangel.

1. Fork the repo ([https://github.com/archangel/archangel/fork](https://github.com/archangel/archangel/fork))
2. Clone the fork to your local machine
3. Run `bundle install` inside `archangel` directory
4. Make your updates or improvements
5. Commit your changes (`git commit -am 'Did some good things'`)
6. Push to your fork (`git push`)
7. Create a new Pull Request

## Testing

Tests are always necessary. If you find yourself thinking, "DO I need to write tests for this?," the answer is yes. [Travis CI](https://travis-ci.org/) is used for running tests. To get the best possible overview of issues with different Ruby versions, Archangel is tested with multiple various of Ruby. See [`.travis.yml`](.travis.yml) for the versions of Ruby tested.

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

Various tools are used to make sure code is linted and formatted correctly.

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

## Security and Maintenance

[Brakeman](https://github.com/presidentbeef/brakeman) is a static analysis security vulnerability scanner. Brakeman issues are reported in [Code Climate](https://codeclimate.com/).

```
$ brakeman
```

or

```
$ bundle exec brakeman
```

## Documentation

[Yard](https://github.com/lsegal/yard) is used to generate documentation. [Online documentation is available](http://www.rubydoc.info/github/archangel/archangel/master)

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

Inch documentation statistics can be generated

```
$ inch
```
