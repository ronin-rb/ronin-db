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
        # Manages all credentials in the database.
        #
        # ## Usage
        #
        #     ronin-db creds [options]
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
        #     -u, --for-user USER              Username to search for
        #     -p, --with-password PASSWORD     Password to search for
        #
        class Creds < ModelCommand

          include Modifiable

          model_file 'ronin/db/credential'
          model_name 'Credential'

          option :for_user, short: '-u',
                            value: {
                              type:  String,
                              usage: 'USER'
                            },
                            desc: 'Username to search for' do |user|
                              @query_method_calls << [:for_user, [user]]
                            end

          option :with_password, short: '-P',
                                 value: {
                                   type:  String,
                                   usage: 'PASSWORD'
                                 },
                                 desc: 'Password to search for' do |password|
                                   @query_method_calls << [:with_password, [password]]
                                 end

          description 'Manages all credentials in the database'

          man_page 'ronin-db-creds.1'

        end
      end
    end
  end
end
