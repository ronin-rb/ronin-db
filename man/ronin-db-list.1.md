# ronin-db-list 1 "2022-01-01" Ronin DB "User Manuals"

## SYNOPSIS

`ronin-db list` [*options*] [*NAME*]

## DESCRIPTION

Lists entries in the `~/.config/ronin-db/database.yml` configuration file.

## ARGUMENTS

*NAME*
  The optional database name to print configuration information for.

## OPTIONS

`-v`, `--verbose`
  Enables verbose output.

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

ronin-db(1) ronin-db-add(1) ronin-db-edit(1) ronin-db-remove(1)
