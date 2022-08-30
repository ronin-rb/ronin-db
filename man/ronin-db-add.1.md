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

## FILES

*~/.config/ronin-db/database.yml*
	The `ronin-db` database(s) configuration file.

## ENVIRONMENT

HOME
	Specifies the home directory of the user. Ronin will search for the
	*~/.config/ronin-db* cache directory within the home directory.

XDG_CONFIG_HOME
  Specifies the cache directory to use. Defaults to *$HOME/.config*.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

## SEE ALSO

ronin-db(1) ronin-db-list(1) ronin-db-edit(1) ronin-db-remove(1)
