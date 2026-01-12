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

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Queries all OSes in the database.
        #
        # ## Usage
        #
        #     ronin-db oses [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #     -v, --verbose                    Enables verbose output
        #     -N, --name NAME                  Searches for all OSes records with the matching name
        #         --named NAME                 Searches for all OSes containing the NAME
        #     -F, --flavor linux|bsd           Searches for all OSes with the flavor
        #     -V, --version VERSION            Searches for all OSes with the VERSION
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class Oses < ModelCommand

          model_file 'ronin/db/os'
          model_name 'OS'

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

          option :flavor, short: '-F',
                          value: {
                            type: [:linux, :bsd]
                          },
                          desc: 'Searches for all OSes with the flavor' do |flavor|
                            @query_method_calls << [:with_flavor, [flavor]]
                          end

          option :version, short: '-V',
                           value: {
                             type:  String,
                             usage: 'VERSION'
                           },
                           desc: 'Searches for all OSes with the VERSION' do |version|
                             @query_method_calls << [:with_version, [version]]
                           end

          description 'Queries OSes'

          man_page 'ronin-db-oses.1'

        end
      end
    end
  end
end
