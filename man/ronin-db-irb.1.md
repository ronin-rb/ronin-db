# ronin-db-irb 1 "2022-01-01" Ronin DB "User Manuals"

## SYNOPSIS

`ronin-db irb` [*options*]

## DESCRIPTION

Connects to a database and start an interactive ruby shell.

## OPTIONS

`--db` *NAME*
  The database to connect to. Will connect to the `default` database if not
  specified.

`--db-uri` *URI*
  The database URI to connect to.

`--no-connect`
  Causes the ruby shell to not connect to a database on startup.

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

ronin-db(1)
