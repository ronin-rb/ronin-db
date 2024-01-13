# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2024 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# ronin-db is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-db is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-db.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/db/cli/command'
require 'ronin/db'

module Ronin
  module DB
    class CLI
      #
      # Mixin which adds methods for parsing database URIs
      # (ex: `sqlite3:path/to/db.sqlite3`).
      #
      module URIMethods
        # Common database adapter names and their ActiveRecord equivalents.
        ADAPTER_ALIASES = {
          'sqlite'   => 'sqlite3',
          'mysql'    => 'mysql2',
          'pg'       => 'postgresql',
          'psql'     => 'postgresql',
          'postgres' => 'postgresql'
        }

        #
        # Normalizes a database adapter name.
        #
        # @param [String] adapter
        #   The adapter name to normalize.
        #
        # @return [String]
        #   The normalized adapter.
        #
        def normalize_adapter(adapter)
          ADAPTER_ALIASES.fetch(adapter,adapter)
        end

        #
        # Normalizes a sqlite3 database path.
        #
        # @param [String] path
        #   The path to the sqlite3 database.
        #
        # @return [String]
        #   The expanded path or `":memory:"` if the path was `":memory:"`.
        #
        def normalize_sqlite3_path(path)
          if path == ':memory:' then path
          else                       File.expand_path(path)
          end
        end

        #
        # Parses a database URI.
        #
        # @param [String] uri
        #   The database URI to parse.
        #
        # @return [Hash{Symbol => String,Integer,nil}]
        #   The database configuration Hash.
        #
        def parse_uri(uri)
          if (match = uri.match(/\Asqlite(?:3)?:(.+)\z/))
            {
              adapter: 'sqlite3',
              database: normalize_sqlite3_path(match[1])
            }
          else
            uri     = URI.parse(uri)
            adapter = normalize_adapter(uri.scheme)

            hash = {adapter: adapter}

            hash[:host]     = uri.host if uri.host
            hash[:port]     = uri.port if uri.port
            hash[:username] = uri.user if uri.user
            hash[:password] = uri.password if uri.password
            hash[:database] = uri.path[1..]

            return hash
          end
        end
      end
    end
  end
end
