#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-db.
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

require 'dm-core'

module Ronin
  module DB
    module Model
      module Types
        #
        # The Description property type is similar to the `Text` type,
        # but automatically strips all leading and tailing white-space
        # from every line.
        #
        class Description < DataMapper::Property::Text

          #
          # Type-casts the description.
          #
          # @param [Object] value
          #   The text of the description.
          #
          # @return [String, nil]
          #   The type-casted description.
          #
          # @since 1.0.0
          #
          # @api private
          #
          def typecast(value)
            unless value.nil?
              value.to_s.lines.map(&:strip).join($/).strip
            end
          end

        end
      end
    end
  end
end