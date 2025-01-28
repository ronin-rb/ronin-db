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

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Queries all Software in the database.
        #
        # ## Usage
        #
        #     ronin-db software [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #     -v, --verbose                    Enables verbose output
        #     -N, --name NAME                  Searches for all OSes records with the matching name
        #         --named NAME                 Searches for all OSes containing the NAME
        #     -V, --version VERSION            Searches for all OSes with the VERSION
        #         --vendor VENDOR              Searches for all Software with the vendor name
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class Software < ModelCommand

          model_file 'ronin/db/software'
          model_name 'Software'

          option :name, short: '-N',
                        value: {
                          type:  String,
                          usage: 'NAME'
                        },
                        desc: 'Searches for all OSes records with the matching name' do |name|
                          @query_method_calls << [:with_name, [name]]
                        end

          option :named, value: {
                           type:  String,
                           usage: 'NAME'
                         },
                         desc: 'Searches for all OSes containing the NAME' do |name|
                           @query_method_calls << [:named, [name]]
                         end

          option :version, short: '-V',
                           value: {
                             type:  String,
                             usage: 'VERSION'
                           },
                           desc: 'Searches for all OSes with the VERSION' do |version|
                             @query_method_calls << [:with_version, [version]]
                           end

          option :vendor, value: {
                            type:  String,
                            usage: 'VENDOR'
                          },
                          desc: 'Searches for all Software with the vendor name' do |vendor|
                            @query_method_calls << [:with_vendor_name, [vendor]]
                          end

          description 'Queries Software'

          man_page 'ronin-db-software.1'

        end
      end
    end
  end
end
