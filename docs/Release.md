# Releasing Gem

1. Clean up generated files

   ```
   $ bundle exec rake clean
   ```

2. Bump the gem version in `lib/archangel/version.rb`

    Follow the rules of [Semantic Versioning](https://semver.org/). For example:

    * `1.2.3`
    * `1.3.0-beta`
    * `2.0.0-rc.1`

  a. If this is a major or minor version update, change the `README.md` file to reflect the version

      ```
      gem "archangel", "~> x.y"
      ```

3. Build the gem

   ```
   $ bundle exec rake build
   ```

   This will create a new .gem file in `pkg/`. Fix any errors or warnings that come up.

4. Commit the version change with commit message "Bump to [X.Y.Z]"

5. Create the gem, tag it in Github and release to Rubygems

    ```
    $ bundle exec rake release
    ```

6. Profit!
