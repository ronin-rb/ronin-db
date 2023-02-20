# ronin-db-add 1 "2022-01-01" Ronin DB "User Manuals"

## SYNOPSIS

`ronin-db add` [*options*] *NAME* [*URI*]

## DESCRIPTION

Lists entries in the `~/.config/ronin-db/database.yml` configuration file.

## ARGUMENTS

*NAME*
  The name of the database to add.

*URI*
  The optional URI to the database to add.

## OPTIONS

`-A`, `--adapter` `sqlite3|mysql2|postgres|...`
  The adapter of the database to add.

`--sqlite3` *FILE*
  Alias for `--adapter sqlite3 --database` *FILE*.

`--mysql2`
  Alias for `--adapter mysql2`.

`--postgresql`
  Alias for `--adapter postgresql`.

`-H`, `--host` *HOST*
  The host of the database to add.

`-p`, `--port` *PORT*
  The port of the database to add.

`-u`, `--username` *USER*
  The username to authenticate with for the database.

`-P`, `--password` *PASSWORD*
  The password to authenticate with for the database.

`--read-password`
  Reads the database password from STDIN.

`-D`, `--database` *NAME*|*PATH*
  The database name to connect to. If `--adapter sqlite3` is given then a path
  may be given instead.

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

*~/.local/share/ronin-db/database.sqlite3*
  The default sqlite3 database file.

*~/.config/ronin-db/database.yml*
  Optional database configuration.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

## SEE ALSO

ronin-db(1) ronin-db-list(1) ronin-db-edit(1) ronin-db-remove(1)
