# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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
        # Manages all Passwords in the database.
        #
        # ## Usage
        #
        #     ronin-db passwords [options]
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
        #     -u, --for-user USER              Searches for all Passwords associated with the USER name
        #     -e, --with-email EMAIL           Searches for all Passwords associated with the EMAIL address
        #
        # @since 0.2.0
        #
        class Passwords < ModelCommand

          include Modifiable

          model_file 'ronin/db/password'
          model_name 'Password'

          option :for_user, short: '-u',
                            value: {
                              type:  String,
                              usage: 'USER'
                            },
                            desc: 'Searches for all Passwords associated with the USER name' do |user|
                              @query_method_calls << [:for_user, [user]]
                            end

          option :with_email, short: '-e',
                              value: {
                                type: String,
                                usage: 'EMAIL'
                              },
                              desc: 'Searches for all Passwords associated with the EMAIL address' do |email|
                                @query_method_calls << [:with_email_address, [email]]
                              end

          description 'Manages all Passwords in the database'

          man_page 'ronin-db-passwords.1'

        end
      end
    end
  end
end
