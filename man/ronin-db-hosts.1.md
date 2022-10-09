# ronin-hosts 1 "April 2012" Ronin "User Manuals"

## SYNOPSIS

`ronin hosts` [*options*]

## DESCRIPTION

Manages host names.

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

`-I`, `--with-ip` *IP*
	Searches for HostNames associated with the IP address.

`-p`, `--with-port` *PORT*
	Searches for HostNames associated with the *PORT*.

`-D`, `--domain` *DOMAIN*
	Searches for HostNames belonging to the DOMAIN (`co.uk`).

`-T`, `--tld` *TLD*
	Searches for HostNames with the Top-Level-Domain (TLD) (`ru`).

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

