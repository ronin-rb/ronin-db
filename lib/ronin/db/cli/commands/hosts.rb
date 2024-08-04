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

require_relative '../model_command'
require_relative '../modifiable'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages all host names in the database.
        #
        # ## Usage
        #
        #     ronin-db hosts [options]
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
        #     -I, --with-ip [IP [...]]
        #     -p, --with-port [PORT [...]]
        #     -D, --domain [DOMAIN]
        #     -T, --tld [TLD]
        #
        class Hosts < ModelCommand

          include Modifiable

          model_file 'ronin/db/host_name'
          model_name 'HostName'

          option :with_ip, short: '-I',
                           value: {
                             type:  String,
                             usage: 'IP'
                           },
                           desc: 'Searches for the associated IP(s)' do |ip|
                             @query_method_calls << [:with_ip_address, [ip]]
                           end

          option :with_port, short: '-p',
                             value: {
                               type:  Integer,
                               usage: 'PORT'
                             },
                             desc: 'Searches for the associated PORT(s)' do |port|
                               @query_method_calls << [:with_port_number, [port]]
                             end

          option :domain, short: '-D',
                          value: {
                            type:  String,
                            usage: 'DOMAIN'
                          },
                          desc: 'Searches for the associated parent DOMAIN' do |domain|
                            @query_method_calls << [:with_domain, [domain]]
                          end

          option :tld, short: '-T',
                       value: {
                         type:  String,
                         usage: 'TLD'
                       },
                       desc: 'Searches for the associated TLD' do |tld|
                         @query_method_calls << [:with_tld, [tld]]
                       end

          description 'Manages HostNames'

          man_page 'ronin-db-hosts.1'

        end
      end
    end
  end
end
