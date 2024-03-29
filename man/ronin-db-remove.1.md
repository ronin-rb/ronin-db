# ronin-db-remove 1 "2023-02-01" Ronin DB "User Manuals"

## SYNOPSIS

`ronin-db remove` [*options*] *NAME*

## DESCRIPTION

Removes a database entry from the `~/.config/ronin-db/database.yml`
configuration file.

## ARGUMENTS

*NAME*
  The database entry to remove.

## OPTIONS

`-h`, `--help`
  Print help information.

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

## SEE ALSO

ronin-db(1) ronin-db-add(1) ronin-db-list(1) ronin-db-edit(1)
