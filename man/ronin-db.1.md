# ronin-db 1 "2023-02-01" Ronin DB "User Manuals"

## NAME

ronin-db - manages ronin's database(s)

## SYNOPSIS

`ronin-db` [*options*] [*COMMAND*]

## DESCRIPTION

The `ronin-db` provides commands for adding, removing, listing, databases,
and querying, inserting, or deleting data from the various tables within a
database.

## OPTIONS

`-h`, `--help`
: Prints help information.

## COMMANDS

`add`
: Adds a pre-existing database to ronin-db.

`asn`
: Queries and updates ASNs.

`certs`
: Queries or imports SSL/TLS certificates.

`completion`
: Manages shell completion rules for the `ronin-db` command.

`creds`
: Manages all credentials in the database.

`edit`
: Manually edits the `database.yml` configuration file.

`emails`
: Manages all email addresses in the database.

`hosts`
: Manages all host names in the database.

`ips`
: Manages IP addresses in the database.

`irb`
: Connects to a database and start an interactive Ruby shell.

`list`
: List the configured database(s).

`migrate`
: Runs database migrations.

`open-ports`
: Queries open ports in the database.

`oses`
: Queries OSes in the database

`passwords`
: Manages all passwords in the database.

`people`
: Queries people in the database.

`phone-numbers`
: Manages phone numbers in the database.

`ports`
: Manages port numbers in the database.

`remove`
: Removes a database from the configuration file.

`services`
: Manages services in the database.

`software`
: Queries software in the database.

`street-addresses`
: Queries street addresses in the database.

`urls`
: Manages URLs in the database.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

## SEE ALSO

[ronin-db-add](ronin-db-add.1.md) [ronin-db-asn](ronin-db-asn.1.md) [ronin-db-certs](ronin-db-certs.1.md) [ronin-db-completion](ronin-db-completion.1.md) [ronin-db-creds](ronin-db-creds.1.md) [ronin-db-edit](ronin-db-edit.1.md) [ronin-db-emails](ronin-db-emails.1.md) [ronin-db-hosts](ronin-db-hosts.1.md) [ronin-db-ips](ronin-db-ips.1.md) [ronin-db-irb](ronin-db-irb.1.md) [ronin-db-list](ronin-db-list.1.md) [ronin-db-migrate](ronin-db-migrate.1.md) [ronin-db-open-ports](ronin-db-open-ports.1.md) [ronin-db-oses](ronin-db-oses.1.md) [ronin-db-passwords](ronin-db-passwords.1.md) [ronin-db-people](ronin-db-people.1.md) [ronin-db-phone-numbers](ronin-db-phone-numbers.1.md) [ronin-db-ports](ronin-db-ports.1.md) [ronin-db-remove](ronin-db-remove.1.md) [ronin-db-services](ronin-db-services.1.md) [ronin-db-software](ronin-db-software.1.md) [ronin-db-street-addresses](ronin-db-street-addresses.1.md) [ronin-db-urls](ronin-db-urls.1.md)
