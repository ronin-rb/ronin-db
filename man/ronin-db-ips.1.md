# ronin-db-ips 1 "April 2012" Ronin "User Manuals"

## SYNOPSIS

`ronin-db ips` [*options*]

## DESCRIPTION

Manages IP addresses.

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

`-4`, `--v4`
	Searches for IPv4 addresses.

`-6`, `--v6`
	Searches for IPv6 addresses.

`-p`, `--with-port` *PORT*
	Searches for IP addresses associated with the user *PORT*.

`-I`, `--with-mac-addr` *MAC*
	Searches for IP addresses associated with the MAC address.

`-I`, `--with-host` *HOST*
	Searches for IP addresses associated with the *HOST*.

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
