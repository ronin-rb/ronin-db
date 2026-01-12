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
        # Manages all PhoneNumbers in the database.
        #
        # ## Usage
        #
        #     ronin-db phone-numbers [options]
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
        #     -P, --for-person FULL_NAME       Searches for phone numbers associated with the person's full name
        #     -O, --for-organization NAME      Searches for phone numbers associated with the organization's name
        #     -c, --with-country-code NUM      Searches for phone numbers with the country code
        #     -a, --with-area-code NUM         Searches for phone numbers with the area code
        #     -p, --with-prefix NUM            Searches for phone numbers with the prefix
        #     -l, --with-line-number NUM       Searches for phone numbers with the line number
        #     -S, --similar-to PHONE_NUMBER    Searches for phone numbers similar to another phone number
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class PhoneNumbers < ModelCommand

          include Modifiable

          command_name 'phone-numbers'

          model_file 'ronin/db/phone_number'
          model_name 'PhoneNumber'

          option :for_person, short: '-P',
                              value: {
                                type:  String,
                                usage: 'FULL_NAME'
                              },
                              desc: "Searches for phone numbers associated with the person's full name" do |full_name|
                                @query_method_calls << [:for_person, [full_name]]
                              end

          option :for_organization, short: '-O',
                                    value: {
                                      type:  String,
                                      usage: 'NAME'
                                    },
                                    desc: "Searches for phone numbers associated with the organization's name" do |name|
                                      @query_method_calls << [:for_organization, [name]]
                                    end

          option :with_country_code, short: '-c',
                                     value: {
                                       type:  String,
                                       usage: 'NUM'
                                     },
                                     desc: 'Searches for phone numbers with the country code' do |country_code|
                                       @query_method_calls << [:with_country_code, country_code]
                                     end

          option :with_area_code, short: '-a',
                                  value: {
                                    type:  String,
                                    usage: 'NUM'
                                  },
                                  desc: 'Searches for phone numbers with the area code' do |area_code|
                                    @query_method_calls << [:with_area_code, area_code]
                                  end

          option :with_prefix, short: '-p',
                               value: {
                                 type:  String,
                                 usage: 'NUM'
                               },
                               desc: 'Searches for phone numbers with the prefix' do |prefix|
                                 @query_method_calls << [:with_prefix, prefix]
                               end

          option :with_line_number, short: '-l',
                                    value: {
                                      type:  String,
                                      usage: 'NUM'
                                    },
                                    desc: 'Searches for phone numbers with the line number' do |line_number|
                                      @query_method_calls << [:with_line_number, line_number]
                                    end

          option :similar_to, short: '-S',
                              value: {
                                type:  String,
                                usage: 'PHONE_NUMBER'
                              },
                              desc: 'Searches for phone numbers similar to another phone number' do |number|
                                @query_method_calls << [:similar_to, number]
                              end

          description 'Queries PhoneNumbers'

          man_page 'ronin-db-phone-numbers.1'

        end
      end
    end
  end
end
