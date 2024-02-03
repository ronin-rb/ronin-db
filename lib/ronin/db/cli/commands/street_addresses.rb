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

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages all StreetAddresses in the database.
        #
        # ## Usage
        #
        #     ronin-db street-addresses [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #     -v, --verbose                    Enables verbose output
        #     -P, --for-person FULL_NAME       Searches for street addresses associated with the person's full name
        #     -O, --for-organization NAME      Searches for street addresses associated with the organization's name
        #     -a, --with-address ADDRESS       Searches for street addresses with the matching address
        #     -c, --with-city CITY             Searches for street addresses with the matching city
        #     -s, --with-state STATE           Searches for street addresses with the matching state
        #     -C, --with-country COUNTRY       Searches for street addresses with the matching country
        #     -z, --with-zipcode ZIPCODE       Searches for street addresses with the matching zipcode
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class StreetAddresses < ModelCommand

          command_name 'street-addresses'

          model_file 'ronin/db/street_address'
          model_name 'StreetAddress'

          option :for_person, short: '-P',
                              value: {
                                type:  String,
                                usage: 'FULL_NAME'
                              },
                              desc: "Searches for street addresses associated with the person's full name" do |full_name|
                                @query_method_calls << [:for_person, [full_name]]
                              end

          option :for_organization, short: '-O',
                                    value: {
                                      type:  String,
                                      usage: 'NAME'
                                    },
                                    desc: "Searches for street addresses associated with the organization's name" do |name|
                                      @query_method_calls << [:for_organization, [name]]
                                    end

          option :with_address, short: '-a',
                                value: {
                                  type:  String,
                                  usage: 'ADDRESS'
                                },
                                desc: 'Searches for street addresses with the matching address' do |address|
                                  @query_method_calls << [:with_address, [address]]
                                end

          option :with_city, short: '-c',
                             value: {
                               type:  String,
                               usage: 'CITY'
                             },
                             desc: 'Searches for street addresses with the matching city' do |city|
                               @query_method_calls << [:with_city, [city]]
                             end

          option :with_state, short: '-s',
                              value: {
                                type:  String,
                                usage: 'STATE'
                              },
                              desc: 'Searches for street addresses with the matching state' do |state|
                                @query_method_calls << [:with_state, [state]]
                              end

          option :with_country, short: '-C',
                                value: {
                                  type:  String,
                                  usage: 'COUNTRY'
                                },
                                desc: 'Searches for street addresses with the matching country' do |country|
                                  @query_method_calls << [:with_country, [country]]
                                end

          option :with_zipcode, short: '-z',
                                value: {
                                  type:  String,
                                  usage: 'ZIPCODE'
                                },
                                desc: 'Searches for street addresses with the matching zipcode' do |zipcode|
                                  @query_method_calls << [:with_zipcode, [zipcode]]
                                end

          description 'Queries StreetAddresses'

          man_page 'ronin-db-street-addresses.1'

        end
      end
    end
  end
end
