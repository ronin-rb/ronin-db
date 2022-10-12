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

`-l`, `--[no-]list`
	Lists the Credentials.

## FILES

*~/.ronin/*
	Ronin configuration directory.

*~/.ronin/database.log*
	Database log.

*~/.ronin/database.sqlite3*
	The default sqlite3 Database file.

*~/.ronin/database.yml*
	Optional Database configuration.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

