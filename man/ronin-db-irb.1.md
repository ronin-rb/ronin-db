# ronin-db-irb 1 "2023-02-01" Ronin DB "User Manuals"

## SYNOPSIS

`ronin-db irb` [*options*]

## DESCRIPTION

Connects to a database and start an interactive Ruby shell.

## OPTIONS

`--db` *NAME*
  The database to connect to. Will connect to the `default` database if not
  specified.

`--db-uri` *URI*
  The database URI to connect to.

  * **sqlite3**: `sqlite3:relative/path.db` or `sqlite3:///absolute/path.db`
  * **mysql**: `mysql://user:password@host/database`
  * **postgres**: `postgres://user:password@host/database`

`--no-connect`
  Causes the Ruby shell to not connect to a database on startup.

`-h`, `--help`
  Print help information.

## ENVIRONMENT

*HOME*
  Alternate location for the user's home directory.

*XDG_CONFIG_HOME*
  Alternate location for the `~/.config` directory.

*XDG_DATA_HOME*
  Alternate location for the `~/.local/share` directory.

## FILES

`~/.local/share/ronin-db/database.sqlite3`
  The default sqlite3 database file.

`~/.config/ronin-db/database.yml`
  Optional database configuration.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

## SEE ALSO

ronin-db(1)
