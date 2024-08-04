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

require_relative '../command'
require_relative '../../config_file'

require 'command_kit/edit'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manually edits the `~/.config/ronin-db/database.yml` configuration
        # file.
        #
        # ## Usage
        #
        #     ronin-db edit [options]
        #
        # ## Options
        #
        #     -h, --help                       Print help information
        #
        class Edit < Command

          include CommandKit::Edit

          description 'Manually edits the database.yml config'

          man_page 'ronin-db-edit.1'

          def run
            edit ConfigFile::PATH
          end

        end
      end
    end
  end
end
