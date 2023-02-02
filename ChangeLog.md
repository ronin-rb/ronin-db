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
