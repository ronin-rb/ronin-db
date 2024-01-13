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
require 'ronin/db/cli/database_options'
require 'ronin/db'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Runs database migrations.
        #
        # ## Usage
        #
        #     ronin-db migrate [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #     -h, --help                       Print help information
        #
        class Migrate < Command

          include DatabaseOptions

          usage '[options]'

          description 'Runs database migrations'

          man_page 'ronin-db-migrate.1'

          #
          # Runs the `ronin-db migrate` command.
          #
          def run
            db_connect
            db_migrate
          end

          #
          # Connects to the database.
          #
          def db_connect
            DB.connect(db_config, load_models: false)
          end

          #
          # Runs migrations.
          #
          def db_migrate
            DB.migrate!
          end

        end
      end
    end
  end
end
