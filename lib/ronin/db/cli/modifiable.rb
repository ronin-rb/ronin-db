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

require_relative 'deletable'
require_relative 'importable'

module Ronin
  module DB
    class CLI
      #
      # Allows a {ModelCommand} to add, import records from a file, delete
      # individual records, or delete all records.
      #
      module Modifiable
        #
        # Adds the `--add`, `--import`, `--delete` and `--delete-all` options
        # to the command.
        #
        # @param [Class<ModelCommand>] command
        #   The command class including {Modifiable}.
        #
        # @see Importable
        # @see Deletable
        #
        def self.included(command)
          command.include Deletable
          command.include Importable
        end
      end
    end
  end
end
