# ronin-db-emails 1 "2023-02-01" Ronin "User Manuals"

## SYNOPSIS

`ronin-db emails` [*options*]

## DESCRIPTION

Manages email addresses.

## OPTIONS

`--db` *NAME*
  The database to connect to. Defaults to `default` if not given.

`--db-uri` *URI*
  The explicit database URI to connect to
  (ex: `mysql://user:password@host/ronin`).

`-v`, `--verbose`
	Enable verbose output.

`--add` *VALUE*
  Adds the email address to the database.

`--import` *FILE*
  Imports the email addresses from the given *FILE*.

`--delete` *VALUE*
  Deletes the email address from the database.

`--delete-all`
  Deletes every email address from the database.

`-H`, `--with-host` *HOST*
	Searches for email addresses associated with the *HOST*.

`-I`, `--with-ip` *IP*
	Searches for email addresses associated with the IP address.

`-u`, `--with-users` *NAME* [...]
	Searches for email addresses associated with the user NAME(s).

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

