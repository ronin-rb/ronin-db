# ronin-db

[![CI](https://github.com/ronin-rb/ronin-db/actions/workflows/ruby.yml/badge.svg)](https://github.com/ronin-rb/ronin-db/actions/workflows/ruby.yml)
[![Code Climate](https://codeclimate.com/github/ronin-rb/ronin-db.svg)](https://codeclimate.com/github/ronin-rb/ronin-db)

* [Website](https://ronin-rb.dev)
* [Source](https://github.com/ronin-rb/ronin-db)
* [Issues](https://github.com/ronin-rb/ronin-db/issues)
* [Documentation](https://ronin-rb.dev/docs/ronin-db/frames)
* [Slack](https://ronin-rb.slack.com) |
  [Discord](https://discord.gg/6WAb3PsVX9) |
  [Twitter](https://twitter.com/ronin_rb)

## Description

ronin-db is a common database library for managing and querying security data.
ronin-db provides common ORM models for interacting with the database's SQL
tables and inserting/querying security data, such as URLs, email addresses,
host names, IPs, ports, etc. ronin-db also provides CLI commands for managing
the database(s).

ronin-db is part of the [ronin-rb] project, a [Ruby] toolkit for security
research and development.

## Features

* Uses a [sqlite] database by default.
* Provides common [ActiveRecord models][ronin-db-activerecord] for interacting
  with the database tables.
* Provides a `ronin-db` command for easy management of the database(s).

## Synopsis

List available Databases:

```shell
$ ronin-db list
```

Add a new Database:

```shell
$ ronin-db add team --uri mysql://user:pass@vpn.example.com/db
```

Remove a Database:

```shell
$ ronin-db remove team
```

## Requirements

* [Ruby] >= 3.0.0
* [sqlite3] ~> 1.0
* [ronin-db-activerecord] ~> 0.1
* [ronin-support] ~> 1.0
* [ronin-core] ~> 0.1

## Install

```shell
$ gem install ronin-db
```

### Gemfile

```ruby
gem 'ronin-db', '~> 0.1'
```

### gemspec

```ruby
gem.add_dependency 'ronin-db', '~> 0.1'
```

## Development

1. [Fork It!](https://github.com/ronin-rb/ronin-db/fork)
2. Clone It!
3. `cd ronin-db`
4. `bundle install`
5. `git checkout -b my_feature`
6. Code It!
7. `bundle exec rake spec`
8. `git push origin my_feature`

If you want to test your changes locally, run `rake db:console` to start a
local database console.

## License

Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)

ronin-db is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ronin-db is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with ronin-db.  If not, see <https://www.gnu.org/licenses/>.

[ronin-rb]: https://ronin-rb.dev/
[Ruby]: https://www.ruby-lang.org

[libsqlite3]: https://sqlite.org/
[uri-query_params]: https://github.com/postmodern/uri-query_params#readme
[sqlite3]: https://github.com/sparklemotion/sqlite3-ruby#readme
[activerecord]: https://github.com/rails/rails/tree/main/activerecord#readme
[ronin-db-activerecord]: https://github.com/ronin-rb/ronin-db-activerecord#readme
[ronin-support]: https://github.com/ronin-rb/ronin-support#readme
[ronin-core]: https://github.com/ronin-rb/ronin-core#readme
