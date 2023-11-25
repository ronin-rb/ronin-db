# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2023 Hal Brodigan (postmodern.mod3 at gmail.com)
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
require 'ronin/db/cli/database_options'
require 'ronin/db/cli/ruby_shell'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Connects to a database and start an interactive Ruby shell.
        #
        # ## Usage
        #
        #     ronin-db irb [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #         --no-connect                 Do not connect to a database on startup
        #     -h, --help                       Print help information
        #
        class Irb < Command

          include DatabaseOptions

          option :no_connect, desc: 'Do not connect to a database on startup'

          description "Connects to a database and start an interactive Ruby shell"

          man_page 'ronin-db-irb.1'

          #
          # Starts the `ronin-db irb` command.
          #
          def run
            unless options[:no_connect]
              db_connect
              load_models
            end

            set_logger

            CLI::RubyShell.start
          end

          def set_logger
            require 'logger'
            DB.logger = Logger.new(stderr,:debug)
          end

          #
          # Loads all models.
          #
          def load_models
            require 'ronin/db/models'
            Ronin::DB::Models.connect
          end

        end
      end
    end
  end
end
