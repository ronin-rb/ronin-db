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

module Ronin
  module DB
    class CLI
      #
      # Allows a {ModelCommand} to add or import records from a file.
      #
      module Importable
        #
        # Adds the `--add` and `--import` options to the command.
        #
        # @param [Class<ModelCommand>] command
        #   The command class including {Importable}.
        #
        def self.included(command)
          command.option :add, value: {
                                 type: String,
                                 usage: 'VALUE'
                               },
                               desc: 'Adds a value to the database'

          command.option :import, value: {
                                    type:  String,
                                    usage: 'FILE'
                                  },
                                  desc: 'Imports the values from the FILE into the database'
        end

        #
        # Runs the command.
        #
        def run
          if options[:add]
            db_connect
            add(options[:add])
          elsif options[:import]
            db_connect
            import_file(options[:import])
          else
            super
          end
        end

        #
        # Adds a value to the database.
        #
        # @param [String] value
        #   The value to add.
        #
        def add(value)
          record = model.import(value)

          unless record.valid?
            print_error "failed to import #{value}!"

            record.errors.full_messages.each do |message|
              print_error " - #{message}"
            end
          end
        end

        #
        # Imports the values from the given file.
        #
        # @param [String] path
        #   The path to the file.
        #
        def import_file(path)
          unless File.file?(path)
            print_error "no such file or directory: #{path}"
            exit(-1)
          end

          File.open(path) do |file|
            model.transaction do
              file.each_line(chomp: true) do |value|
                log_info "Importing #{value} ..." if verbose?

                add(value)
              end
            end
          end
        end
      end
    end
  end
end
