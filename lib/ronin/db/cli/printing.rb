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

module Ronin
  module DB
    class CLI
      #
      # Helper methods for printing {Ronin::DB} records.
      #
      # @since 0.2.0
      #
      module Printing
        #
        # Maps a record to a human readable display name.
        #
        # @param [Ronin::DB::IPAddress,
        #         Ronin::DB::MACAddress,
        #         Ronin::DB::HostName,
        #         Ronin::DB::Port,
        #         Ronin::DB::Service,
        #         Ronin::DB::OpenPort] record
        #
        # @return [String, nil]
        #   The human readable type or `nil` if the record model is unknown.
        #
        def record_type(record)
          case record
          when HostName   then 'host'
          when IPAddress  then 'IP'
          when MACAddress then 'MAC'
          when Port       then 'port'
          when Service    then 'service'
          when OpenPort   then 'open port'
          end
        end
      end
    end
  end
end
