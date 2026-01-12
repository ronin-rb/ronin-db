# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
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
        # Manages all People in the database.
        #
        # ## Usage
        #
        #     ronin-db people [options]
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
        #     -a, --for-address ADDRESS        Searches for all People associated with the street address
        #     -c, --for-city CITY              Searches for all People associated with the city
        #     -s, --for-state STATE            Searches for all People associated with the state
        #     -s, --for-province PROVINCE      Searches for all People associated with the province
        #     -z, --for-zipcode ZIPCODE        Searches for all People associated with the zipcode
        #     -C, --for-country COUNTRY        Searches for all People associated with the Country
        #     -P, --with-prefix PREFIX         Searches for all People with the prefix
        #     -f, --with-first-name NAME       Searches for all People with the first name
        #     -m, --with-middle-name NAME      Searches for all People with the middle name
        #     -M INITIAL,                      Searches for all People with the middle name
        #         --with-middle-initial
        #     -l, --with-last-name NAME        Searches for all People with the last name
        #     -S, --with-suffix SUFFIX         Searches for all People with the suffix
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class People < ModelCommand

          include Modifiable

          model_file 'ronin/db/person'
          model_name 'Person'

          option :for_address, short: '-a',
                               value: {
                                 type:  String,
                                 usage: 'ADDRESS'
                               },
                               desc: 'Searches for all People associated with the street address' do |address|
                                 @query_method_calls << [:for_address, [address]]
                               end

          option :for_city, short: '-c',
                            value: {
                              type:  String,
                              usage: 'CITY'
                            },
                            desc: 'Searches for all People associated with the city' do |city|
                              @query_method_calls << [:for_city, [city]]
                            end

          option :for_state, short: '-s',
                             value: {
                               type:  String,
                               usage: 'STATE'
                             },
                             desc: 'Searches for all People associated with the state' do |state|
                               @query_method_calls << [:for_state, [state]]
                             end

          option :for_province, short: '-p',
                                value: {
                                  type:  String,
                                  usage: 'PROVINCE'
                                },
                                desc: 'Searches for all People associated with the province' do |province|
                                  @query_method_calls << [:for_province, [province]]
                                end

          option :for_zipcode, short: '-z',
                               value: {
                                 type:  String,
                                 usage: 'ZIPCODE'
                               },
                               desc: 'Searches for all People associated with the zipcode' do |zipcode|
                                 @query_method_calls << [:for_zipcode, [zipcode]]
                               end

          option :for_country, short: '-C',
                               value: {
                                 type:  String,
                                 usage: 'COUNTRY'
                               },
                               desc: 'Searches for all People associated with the Country' do |country|
                                 @query_method_calls << [:for_country, [country]]
                               end

          option :with_prefix, short: '-P',
                               value: {
                                 type:  String,
                                 usage: 'PREFIX'
                               },
                               desc: 'Searches for all People with the prefix' do |prefix|
                                 @query_method_calls << [:with_prefix, [prefix]]
                               end

          option :with_first_name, short: '-f',
                                   value: {
                                     type:  String,
                                     usage: 'NAME'
                                   },
                                   desc: 'Searches for all People with the first name' do |name|
                                     @query_method_calls << [:with_first_name, [name]]
                                   end

          option :with_middle_name, short: '-m',
                                    value: {
                                      type:  String,
                                      usage: 'NAME'
                                    },
                                    desc: 'Searches for all People with the middle name' do |name|
                                      @query_method_calls << [:with_middle_name, [name]]
                                    end

          option :with_middle_initial, short: '-M',
                                       value: {
                                         type:  String,
                                         usage: 'INITIAL'
                                       },
                                       desc: 'Searches for all People with the middle name' do |initial|
                                         @query_method_calls << [:with_middle_initial, [initial]]
                                       end

          option :with_last_name, short: '-l',
                                  value: {
                                    type:  String,
                                    usage: 'NAME'
                                  },
                                  desc: 'Searches for all People with the last name' do |name|
                                    @query_method_calls << [:with_last_name, [name]]
                                  end

          option :with_suffix, short: '-S',
                               value: {
                                 type:  String,
                                 usage: 'SUFFIX'
                               },
                               desc: 'Searches for all People with the suffix' do |suffix|
                                 @query_method_calls << [:with_suffix, [suffix]]
                               end

          description 'Queries People'

          man_page 'ronin-db-people.1'

        end
      end
    end
  end
end
