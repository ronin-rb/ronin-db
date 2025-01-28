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

require_relative '../command'
require_relative '../../config_file'

require 'command_kit/options/verbose'
require 'command_kit/printing'
require 'command_kit/printing/indent'
require 'command_kit/printing/fields'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Lists entries in the `~/.config/ronin-db/database.yml` configuration
        # file.
        #
        # ## Usage
        #
        #     ronin-db list [options] [NAME]
        #
        # ## Options
        #
        #     -v, --verbose                    Enables verbose output
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     [NAME]                           Optional DB name to list
        #
        class List < Command

          include CommandKit::Options::Verbose
          include CommandKit::Printing
          include CommandKit::Printing::Indent
          include CommandKit::Printing::Fields

          usage '[options] [NAME]'

          argument :name, required: false,
                          desc:     'Optional DB name to list'

          description 'List the configured database(s)'

          man_page 'ronin-db-list.1'

          #
          # Runs the `ronin-db list` command.
          #
          # @param [String, nil] name
          #   The optional database name to list.
          #
          def run(name=nil)
            config = ConfigFile.load

            if name
              unless (hash = config[name.to_sym])
                print_error "unknown database #{name.inspect}"
                exit(1)
              end

              print_database(name,hash)
            else
              config.each do |name,hash|
                if verbose?
                  print_database(name,hash)
                  puts
                else
                  puts name
                end
              end
            end
          end

          # Default hidden password placeholder.
          HIDDEN_PASSWORD = '*******'

          #
          # Prints a specific entry in the `database.yml` file.
          #
          # @param [Symbol] name
          #   The database name.
          #
          # @param [Hash{Symbol => String,Integer}] hash
          #   The configuration hash for the database.
          #
          def print_database(name,hash)
            puts "[ #{name} ]"
            puts

            if hash[:password]
              # blank out the password by default
              hash = hash.merge(password: HIDDEN_PASSWORD)
            end

            indent(2) do
              print_fields(hash)
            end
          end

        end
      end
    end
  end
end
