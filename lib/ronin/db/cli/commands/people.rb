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

          model_file 'ronin/db/person'
          model_name 'Person'

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
