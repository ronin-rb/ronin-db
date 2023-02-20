# ronin-db-creds 1 "April 2012" Ronin "User Manuals"

## SYNOPSIS

`ronin-db creds` [*options*]

## DESCRIPTION

Manages credentials.

## OPTIONS

`--db` *NAME*
  The database to connect to. Defaults to `default` if not given.

`--db-uri` *URI*
  The explicit database URI to connect to
  (ex: `mysql://user:password@host/ronin`).

`-v`, `--verbose`
	Enable verbose output.

`--add` *USER*:*PASSWORD*
  Adds the *USER* and *PASSWORD* to the database.

`--import` *FILE*
  Imports the credentials from the given *FILE*.

`--delete` *VALUE*
  Deletes a value from the database.

`--delete-all`
  Deletes every value from the database.

`-u`, `--for-user` *USER*
	Searches for Credentials associated with the USER.

`-p`, `--with-password` *PASSWORD*
	Searches for Credentials that have the PASSWORD.

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

