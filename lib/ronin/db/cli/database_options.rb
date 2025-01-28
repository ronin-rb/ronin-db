# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative 'uri_methods'
require_relative '../../db'

module Ronin
  module DB
    class CLI
      #
      # Base class for all commands that access the database.
      #
      # @since 0.2.0
      #
      module DatabaseOptions
        include URIMethods

        #
        # Adds the `--db`, `--db-uri`, and `--db-file` options to the command
        # class including the {DatabaseOptions} module.
        #
        # @param [Class<Ronin::Core::CLI::Command>] command
        #   The command class including {DatabaseOptions}.
        #
        def self.included(command)
          command.option :db, value: {
                                type:    DB.config.keys,
                                default: :default,
                                usage:   'NAME'
                              },
                              desc: 'The database to connect to'

          command.option :db_uri, value: {
                                    type:  String,
                                    usage: 'URI'
                                  },
                                  desc: 'The database URI to connect to'

          command.option :db_file, value: {
                                     type:  String,
                                     usage: 'PATH'
                                   },
                                   desc: 'The sqlite3 database file to use'
        end

        #
        # The database connection configuration.
        #
        # @return [Hash{Symbol => String,Integer}]
        #
        def db_config
          if options[:db_file]
            {sqlite3: normalize_sqlite3_path(options[:db_file])}
          elsif options[:db_uri]
            parse_uri(options[:db_uri])
          else
            DB.config[options[:db]]
          end
        end

        #
        # Connects to the database.
        #
        def db_connect
          DB.connect(db_config)
        end
      end
    end
  end
end
