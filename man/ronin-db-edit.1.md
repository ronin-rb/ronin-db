# ronin-db-edit 1 "2022-01-01" Ronin DB "User Manuals"

## SYNOPSIS

`ronin-db edit` [*options*]

## DESCRIPTION

Manually edits the `~/.config/ronin-db/database.yml` configuration file.

## OPTIONS

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

ronin-db(1) ronin-db-add(1) ronin-db-list(1) ronin-db-remove(1)
