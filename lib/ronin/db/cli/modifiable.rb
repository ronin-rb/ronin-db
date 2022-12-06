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

module Ronin
  module DB
    class CLI
      #
      # Allows a {ModelCommand} to add, import, delete, or delete all records.
      #
      module Modifiable
        #
        # Adds the `--add`, `--import`, `--delete`, and `--delete-all` options
        # to the command.
        #
        # @param [Class<ModelCommand>] command
        #   The command class including {Modifiable}.
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

          command.option :delete, value: {
                                    type: String,
                                    usage: 'VALUE'
                                  },
                                  desc: 'Deletes a value from the database'

          command.option :delete_all, desc: 'Deletes all values from the database'
        end

        #
        # Runs the command.
        #
        def run
          connect

          if options[:add]
            add(options[:add])
          elsif options[:import]
            import_file(options[:import])
          elsif options[:delete]
            delete(options[:delete])
          elsif options[:delete_all]
            delete_all
          else
            list
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
        # Imports the values from the givne file.
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

        #
        # Deletes a value from the database.
        #
        # @param [String] value
        #   The value to lookup and delete.
        #
        def delete(value)
          if (record = model.lookup(value))
            record.destroy
          else
            print_error "value does not exist in the database: #{value}"
            exit(-1)
          end
        end

        #
        # Deletes all values from the database.
        #
        def delete_all
          model.destroy_all
        end
      end
    end
  end
end
