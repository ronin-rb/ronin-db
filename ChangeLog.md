### 0.2.0 / 2024-07-22

* Require [ronin-db-activerecord] ~> 0.2.
* Require [ronin-core] ~> 0.2.
* Added {Ronin::DB::Tasks}.
* Added the `pool:` keyword argument to {Ronin::DB.connect}.
* Allow {Ronin::DB.connect} to accept a String URL.

#### CLI

* Added the `--db-file` option to all `ronin-db` commands.
* Added the `ronin-db completion` command to install shell completion files for
  all `ronin-db` commands for Bash and Zsh shells.
* Added the `ronin-db ports` command.
* Added the `ronin-db open-ports` command.
* Added the `ronin-db services` command.
* Added the `ronin-db oses` command.
* Added the `ronin-db software` command.
* Added the `ronin-db certs` command.
* Added the `ronin-db passwords` command.
* Added the `ronin-db people` command.
* Added the `ronin-db street-addresses` command.
* Added the `ronin-db phone-numbers` command.
* Added the `ronin-db web-vulns` command.
* Added the `--named` option to the `ronin-db asn` command.
* Added the `--for-person` option to the `ronin-db emails` command.
* Added the `--for-organization` option to the `ronin-db emails` command.
* Alias `ronin-db console` to `ronin-db irb`.

### 0.1.3 / 2023-12-13

* Fixed a bug in {Ronin::DB::ConfigFile.edit} when `YAML::Store` would attempt
  to create the config file but the parent directory did not exist yet.

### 0.1.2 / 2023-09-19

* Fixed a typo in an exception message in {Ronin::DB.connect}.
* Documentation fixes and improvements.

### 0.1.1 / 2023-06-09

#### CLI

* Fixed typos in the `ronin-db add` man-page.
* Fixed typos in the `ronin-db creds` man-page.
* Fixed formatting of man-pages.

### 0.1.0 / 2023-02-01

* Initial release:
  * Uses a [sqlite] database by default.
  * Provides common [ActiveRecord models][ronin-db-activerecord] for interacting
    with the database tables.
  * Provides a `ronin-db` command for easy management of the database(s).
  * Provides additional commands for querying, inserting, deleting entries from
    various database tables.

[sqlite]: https://sqlite.org/
[ronin-db-activerecord]: https://github.com/ronin-rb/ronin-db-activerecord#readme
[ronin-core]: https://github.com/ronin-rb/ronin-core#readme
