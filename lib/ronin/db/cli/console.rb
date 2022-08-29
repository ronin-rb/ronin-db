#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/core/cli/console'

module Ronin
  module DB
    class CLI
      #
      # The interactive Ruby console for {Ronin::DB}.
      #
      class Console < Core::CLI::Console

        #
        # Initializes the `ronin-db` console.
        #
        # @param [String] name
        #   The name of the IRB console.
        #
        # @param [Object] context
        #   Custom context to launch IRB from within.
        #
        # @param [Hash{Symbol => Object}] kwargs
        #   Additional keyword arguments for
        #   `Ronin::Core::CLI::Console#initialize`.
        #
        def initialize(name: 'ronin-db', context: Ronin::DB, **kwargs)
          super(name: name, context: context, **kwargs)
        end

      end
    end
  end
end
