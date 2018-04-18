# Releasing Gem

1. Bump the gem version in `lib/archangel/version.rb`

    Follow the rules of [Semantic Versioning](https://semver.org/). For example:

    * `1.2.3`
    * `1.3.0-beta`
    * `2.0.0-rc.1`

2. Build the gem

   ```
   $ bundle exec rake build
   ```

   This will create a new .gem file in `pkg/`. Fix any errors or warnings that come up.

3. Create the gem, tag it in Github and release to Rubygems

    ```
    $ bundle exec rake release
    ```

4. Profit!
