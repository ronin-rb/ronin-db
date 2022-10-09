# ronin-urls 1 "April 2012" Ronin "User Manuals"

## SYNOPSIS

`ronin urls` [*options*]

## DESCRIPTION

Manages URLs.

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

`--http`
	Searches for `http://` URLs.

`--https`
	Searches for `https://` URLs.

`-H`, `--host` *HOST*
	Searches for URLs with the given *HOST*.

`-p`, `--with-port` *PORT*
	Searches for URLs associated with the *PORT*.

`-d`, `--directory` *DIRECTORY*
	Searches for URLs sharing the DIRECTORY.

`-q`, `--with-query-param` *NAME* [...]
	Searches for URLs containing the query-param NAME.

`-Q`, `--with-query-value` *VALUE* [...]
	Searches for URLs containing the query-param VALUE.

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

