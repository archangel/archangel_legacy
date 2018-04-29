# Archangel Development

This is documentation for developing the Archangel gem

Documentation for theme developers [is available](https://github.com/archangel/archangel/blob/master/docs/ThemeDevelopers.md).

Documentation for theme developers [is available](https://github.com/archangel/archangel/blob/master/docs/ExtensionDevelopers.md).

## Testing

[Travis CI](https://travis-ci.org/) is used for running tests. To get the best possible overview of issues with different Ruby versions, Archangel is tested with multiple various of Ruby. See [.travis.yml](https://github.com/archangel/archangel/blob/master/.travis.yml) for the versions of Ruby tested.

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

Various tools are used to ensure code is linted and formatted correctly.

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

### scss-lint

[scss-lint](https://github.com/brigade/scss-lint) is a SCSS style analyzer.

```
$ scss-lint .
```

## Security and Maintenance

[Brakeman](https://github.com/presidentbeef/brakeman) is a static analysis security vulnerability scanner. Brakeman issues are reported in [Code Climate](https://codeclimate.com/).

```
$ bundle exec brakeman
$ open brakeman.html
```

### Cleanup

Remove all generated files

```
$ bundle exec rake clean
```

## Documentation

[Yard](https://github.com/lsegal/yard) is used to generate documentation. [Online documentation is available](http://www.rubydoc.info/github/archangel/archangel/master)

Build the documentation

```
$ yard doc
```

Build the documentation and list all undocumented objects

```
$ yard stats --list-undoc
```

[Inch](https://inch-ci.org/) documentation statistics can be generated

```
$ inch
```

## Releasing

Documentation for maintainers to release a new gem version [is available](https://github.com/archangel/archangel/blob/master/docs/Release.md).
