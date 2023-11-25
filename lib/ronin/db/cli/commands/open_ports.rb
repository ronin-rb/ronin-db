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

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages all OpenPorts in the database.
        #
        # ## Usage
        #
        #     ronin-db open-ports [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #     -v, --verbose                    Enables verbose output
        #         --add VALUE                  Adds a value to the database
        #         --import FILE                Imports the values from the FILE into the database
        #         --delete VALUE               Deletes a value from the database
        #         --delete-all                 Deletes all values from the database
        #     -p, --with-port PORT             Searches for all OpenPorts associated with the PORT number
        #     -P, --with-protocol tcp|udp      Searches for all OpenPorts associated with the protocol
        #     -S, --with-service SERVICE       Searches for all OpenPorts associated with the SERVICE
        #     -I, --with-ip IP                 Searches for all OpenPorts associated with the IP
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class OpenPorts < ModelCommand

          model_file 'ronin/db/open_port'
          model_name 'OpenPort'

          option :with_port, short: '-p',
                             value: {
                               type: Integer,
                               usage: 'PORT'
                             },
                             desc: 'Searches for all OpenPorts with the PORT number' do |port|
                               @query_method_calls << [:with_port_number, [port]]
                             end

          option :with_protocol, short: '-P',
                                 value: {
                                   type: [:tcp, :udp]
                                 },
                                 desc: 'Searches for all OpenPorts associated with the protocol' do |protocol|
                                   @query_method_calls << [:with_protocol, [protocol]]
                                 end

          option :with_service, short: '-S',
                                value: {
                                  type:  String,
                                  usage: 'SERVICE'
                                },
                                desc: 'Searches for all OpenPorts associated with the SERVICE' do |service|
                                  @query_method_calls << [:with_service_name, [service]]
                                end

          option :with_ip, short: '-I',
                           value: {
                             type:  String,
                             usage: 'IP'
                           },
                           desc: 'Searches for all OpenPorts associated with the IP' do |ip|
                             @query_method_calls << [:with_ip_address, [ip]]
                           end

          description 'Queries OpenPorts'

          man_page 'ronin-db-open-ports.1'

        end
      end
    end
  end
end
