# ronin-db-asn 1 "April 2012" Ronin "User Manuals"

## SYNOPSIS

`ronin-db asn` [*options*]

## DESCRIPTION

Queries or updates Autonomous System Numbers (ASNs) in the database.

## OPTIONS

`--db` *NAME*
  The database name to connect to. Defaults to `default` if not given.

`--db-uri` *URI*
  The explicit database URI to connect to
  (ex: `postgres://user:password@host/db`).

`-v`, `--verbose`
  Enables verbose output

`-n`, `--number` *INT*
  Searches for all ASN records with the AS number.

`-C`, `--country-code` *XX*\|`None`\|`Uknown`
  Searches for all ASN records with the country code.

`-N`, `--name` *NAME*
  Searches for all ASN records with the matching name.

`-I`, `--ip` *IP*
  Queries the ASN record for the IP.

`-4`, `--ipv4`
  Filter ASN records for only IPv4 ranges.

`-6`, `--ipv6`
  Filter ASN records for only IPv6 ranges.

`-u`, `--update`
  Updates the ASN records.

`-U`, `--url` *URI*
  Overrides the default ASN list URL.
  Defaults to `https://iptoasn.com/data/ip2asn-combined.tsv.gz` if not given.

`-f`, `--file` *FILE*
  Overrides the default ASN list file.
  Defaults to `~/.local/share/ronin/ronin-support/ip2asn-combined.tsv.gz`
  if not given.

`-h`, `--help`
  Print help information.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>
