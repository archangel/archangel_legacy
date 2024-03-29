# Archangel Development

This is documentation for developing the Archangel gem

Documentation for extension developers [is available](https://github.com/archangel/archangel/blob/master/docs/Extension/Developers.md).

Documentation for theme developers [is available](https://github.com/archangel/archangel/blob/master/docs/Theme/Developers.md).

## Testing

[Travis CI](https://travis-ci.org/) is used for running tests. To get the best possible overview of issues with different Ruby versions, Archangel is tested with multiple various of Ruby. See [.travis.yml](https://github.com/archangel/archangel/blob/master/.travis.yml) for the versions of Ruby tested.

Generate a dummy application. You will be required to generate a dummy application before running tests.

```
$ bundle exec rake dummy_app
```

Run tests with any of the following

```
$ bundle exec rake
$ bundle exec rake spec
$ bundle exec rake test
$ bundle exec rspec spec
```

You can also enable fail fast in order to stop tests at the first failure

```
$ bundle exec rspec spec --fail-fast
```

## Code Analysis

Various tools are used to ensure code is linted and formatted correctly.

### ESLint

[eslint](https://eslint.org/) is a Javascript lint and style analyzer.

```
$ eslint .
```

> NOTE: Integrations for multiple text editors and IDEs are [also available](https://eslint.org/docs/user-guide/integrations).

### Reek

[Reek](https://github.com/troessner/reek) is a code smell detector for Ruby.

```
$ reek
```

> NOTE: Integrations for multiple text editors and IDEs are [also available](https://github.com/troessner/reek#editor-integrations).

### RuboCop

[RuboCop](https://github.com/bbatsov/rubocop) is a Ruby static code analyzer.

```
$ rubocop
```

### Sass Lint

[sass-lint](https://github.com/sasstools/sass-lint) is a Sass linter.

```
$ sass-lint -v
```

> NOTE: Integrations for multiple text editors and IDEs are [also available](https://github.com/sasstools/sass-lint#ide-integration).

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
