# frozen_string_literal: true
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
require 'ronin/db/cli/modifiable'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages email addresses in the database.
        #
        # ## Usage
        #
        #     ronin-db emails [options]
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
        #     -H, --with-host [HOST [...]]
        #     -I, --with-ip [IP [...]]
        #     -u, --with-user [NAME [...]]
        #
        class Emails < ModelCommand

          include Modifiable

          model_file 'ronin/db/email_address'
          model_name 'EmailAddress'

          option :with_host, short: '-H',
                             value: {
                               type:  String,
                               usage: 'HOST'
                             },
                             desc: 'Searches for the associated HOST(s)' do |host|
                               @query_method_calls << [:with_host_name, [host]]
                             end

          option :with_ip, short: '-I',
                           value: {
                             type:  String,
                             usage: 'IP'
                           },
                           desc: 'Searches for the associated IP(s)' do |ip|
                             @query_method_calls << [:with_ip_address, [ip]]
                           end

          option :with_user, short: '-u',
                             value: {
                               type:  String,
                               usage: 'USER'
                             },
                             desc: 'Searches for the associated user name' do |user|
                               @query_method_calls << [:with_user_name, [user]]
                             end

          description 'Manages all email addresses in the database'

          man_page 'ronin-db-emails.1'

        end
      end
    end
  end
end
