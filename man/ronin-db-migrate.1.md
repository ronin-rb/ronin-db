# ronin-db-migrate 1 "2022-01-01" Ronin DB "User Manuals"

## SYNOPSIS

`ronin-db migrate` [*options*]

## DESCRIPTION

Runs database migrations.

## OPTIONS

`--db` *NAME*
  The database to connect to. Will connect to the `default` database if not
  specified.

`--db-uri` *URI*
  The database URI to connect to.

`--no-connect`
  Causes the Ruby shell to not connect to a database on startup.

`-h`, `--help`
  Print help information.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

## SEE ALSO

ronin-db-add(1)
