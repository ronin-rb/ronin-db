# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative '../command'
require_relative '../../config_file'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Removes an entry from the `database.yml` config file.
        #
        # ## Usage
        #
        #     ronin-db remove [options] NAME
        #
        # ## Options
        #
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     NAME                             The DB name to remove
        #
        class Remove < Command

          usage '[options] NAME'

          argument :name, desc: 'The DB name to remove'

          description 'Removed a database from the configuration file'

          man_page 'ronin-db-remove.1'

          #
          # Runs the `ronin-db remove` command.
          #
          # @param [String] name
          #   The database name to remove.
          #
          def run(name)
            ConfigFile.edit do |config|
              config.delete(name.to_sym)
            end
          end

        end
      end
    end
  end
end
