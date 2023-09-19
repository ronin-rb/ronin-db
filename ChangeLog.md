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
