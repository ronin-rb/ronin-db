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

require 'ronin/db/cli/model_command'
require 'ronin/db/cli/modifiable'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages all Services in the database.
        #
        # ## Usage
        #
        #     ronin-db services [options]
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
        #         --named NAME                 Searches for all Services containing the NAME
        #     -p, --with-port PORT             Searches for all Services associated with the PORT
        #     -P, --with-protocol tcp|udp      Searches for all Services associated with the protocol
        #     -I, --with-ip IP                 Searches for all Services associated with the IP
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class Services < ModelCommand

          include Modifiable

          model_file 'ronin/db/service'
          model_name 'Service'

          option :named, value: {
                           type:  String,
                           usage: 'NAME'
                         },
                         desc: 'Searches for all Services containing the NAME' do |name|
                           @query_method_calls << [:named, [name]]
                         end

          option :with_port, short: '-p',
                             value: {
                               type: Integer,
                               usage: 'PORT'
                             },
                             desc: 'Searches for all Services associated with the PORT' do |port|
                               @query_method_calls << [:with_port_number, [port]]
                             end

          option :with_protocol, short: '-P',
                                 value: {
                                   type: [:tcp, :udp]
                                 },
                                 desc: 'Searches for all Services associated with the protocol' do |protocol|
                                   @query_method_calls << [:with_protocol, [protocol]]
                                 end

          option :with_ip, short: '-I',
                           value: {
                             type:  String,
                             usage: 'IP'
                           },
                           desc: 'Searches for all Services associated with the IP' do |ip|
                             @query_method_calls << [:with_ip_address, [ip]]
                           end

          description 'Manages Services'

          man_page 'ronin-db-services.1'

        end
      end
    end
  end
end
