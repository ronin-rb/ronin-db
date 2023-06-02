# ronin-db-ips 1 "2023-02-01" Ronin "User Manuals"

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

`--add` *VALUE*
  Adds the IP address to the database.

`--import` *FILE*
  Imports the IP addresses from the given *FILE*.

`--delete` *VALUE*
  Deletes a IP address from the database.

`--delete-all`
  Deletes every IP address from the database.

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

