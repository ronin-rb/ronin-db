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

module Ronin
  module DB
    class CLI
      #
      # Allows a {ModelCommand} to delete a single record or all records.
      #
      # @since 0.2.0
      #
      module Deletable
        #
        # Adds the `--delete` and `--delete-all` options to the command.
        #
        # @param [Class<ModelCommand>] command
        #   The command class including {Deletable}.
        #
        def self.included(command)
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
          if options[:delete]
            db_connect
            delete(options[:delete])
          elsif options[:delete_all]
            db_connect
            delete_all
          else
            super
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
