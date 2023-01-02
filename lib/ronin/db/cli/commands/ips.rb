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

require 'ronin/db/cli/model_command'
require 'ronin/db/cli/modifiable'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages IP addresses in the database.
        #
        # ## Usage
        #
        #     ronin ips [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #     -v, --verbose                    Enables verbose output
        #         --add VALUE                  Adds a value to the database
        #         --import FILE                Imports the values from the FILE into the database
        #         --delete VALUE               Deletes a value from the database
        #         --delete-all                 Deletes all values from the database
        #     -4, --v4
        #     -6, --v6
        #     -p, --with-port PORT
        #     -M, --with-mac-addr MAC
        #     -H, --with-host HOST
        #
        class Ips < ModelCommand

          include Modifiable

          model_file 'ronin/db/ip_address'
          model_name 'IPAddress'

          option :v4, short: '-4',
                      desc: 'Searches for IPv4 addresses' do
                        @query_method_calls << :v4
                      end

          option :v6, short: '-6',
                      desc: 'Searches for IPv6 addresses' do
                        @query_method_calls << :v6
                      end

          option :with_port, short: '-p',
                             value: {
                               type: Integer,
                               usage: 'PORT'
                             },
                             desc: 'Searches for the associated PORT(s)' do |port|
                               @query_method_calls << [:with_port_number, [port]]
                             end

          option :with_mac_addr, short:  '-M',
                                 value: {
                                   type: String,
                                   usage: 'MAC'
                                 },
                                 desc: 'Searches for the associated MAC address(es)' do |mac|
                                   @query_method_calls << [:with_mac_address, [mac]]
                                 end

          option :with_host, short: '-H',
                             value: {
                               type: String,
                               usage: 'HOST'
                             },
                             desc: 'Searches for the associated HOST(s)' do |host|
                               @query_method_calls << [:with_host_name, [host]]
                             end

          description 'Manages IP addresses'

        end
      end
    end
  end
end
