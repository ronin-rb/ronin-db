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

require 'ronin/db/cli/model_command'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages {IPAddress IPAddresses}.
        #
        # ## Usage
        #
        #     ronin ips [options]
        #
        # ## Options
        #
        #      -v, --[no-]verbose               Enable verbose output.
        #      -q, --[no-]quiet                 Disable verbose output.
        #          --[no-]silent                Silence all output.
        #      -D, --database [URI]             The Database URI.
        #          --[no-]csv                   CSV output.
        #          --[no-]xml                   XML output.
        #          --[no-]yaml                  YAML output.
        #          --[no-]json                  JSON output.
        #      -i, --import [FILE]
        #      -4, --[no-]v4
        #      -6, --[no-]v6
        #      -p, --with-ports [PORT [...]]
        #      -M, --with-macs [MAC [...]]
        #      -H, --with-hosts [HOST [...]]
        #          --[no-]list                  Default: true
        #      -L, --lookup [HOST]
        #
        class Ips < ModelCommand

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
