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

require 'ronin/db/cli/database_command'
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
        #     -h, --help                       Print help information
        #
        class Migrate < DatabaseCommand

          usage '[options]'

          description 'Runs database migrations'

          man_page 'ronin-db-migrate.1'

          #
          # Runs the `ronin-db migrate` command.
          #
          def run
            connect
            migrate
          end

          #
          # Connects to the database.
          #
          def connect
            DB.connect(config, load_models: false)
          end

          #
          # Runs migrations.
          #
          def migrate
            DB.migrate!
          end

        end
      end
    end
  end
end
