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
        # Queries all credentials in the database.
        #
        # ## Usage
        #
        #     ronin creds [options]
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
        #     -u, --user [USER]                Username to search for.
        #     -p, --password [PASS]            Password to search for.
        #
        class Creds < ModelCommand

          model_file 'ronin/db/credential'
          model_name 'Credential'

          option :user, short: '-u',
                        value: {
                          type:  String,
                          usage: 'USER'
                        },
                        desc: 'Username to search for' do |user|
                          @query_method_calls << [:for_user, [user]]
                        end

          option :password, short: '-P',
                            value: {
                              type:  String,
                              usage: 'PASSWORD'
                            },
                            desc: 'Password to search for' do |password|
                              @query_method_calls << [:with_password, [password]]
                            end

          description 'Queries all credentials in the database'

          man_page 'ronin-db-creds.1'

        end
      end
    end
  end
end
