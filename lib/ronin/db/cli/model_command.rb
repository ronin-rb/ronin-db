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

require 'ronin/db/cli/database_command'
require 'ronin/core/cli/logging'

require 'command_kit/options/verbose'

module Ronin
  module DB
    class CLI
      #
      # A base-command for database models commands.
      #
      class ModelCommand < DatabaseCommand

        include CommandKit::Options::Verbose
        include Core::CLI::Logging

        #
        # Sets or gets the model file to require.
        #
        # @param [String, nil] new_model_file
        #   The new model file.
        #
        # @return [String]
        #   The model file to require.
        #
        # @raise [NotImplementedError]
        #   The class did not define a `model_file`.
        #
        # @example
        #   model_file 'ronin/db/foo'
        #
        def self.model_file(new_model_file=nil)
          if new_model_file
            @model_file = new_model_file
          else
            @model_file ||= if superclass < ModelCommand
                              superclass.model_file
                            else
                              raise(NotImplementedError,"#{self} did not define model_file")
                            end
          end
        end

        #
        # Sets or gets the model name to require.
        #
        # @param [String, nil] new_model_name
        #   The new model name.
        #
        # @return [String]
        #   The model name to require.
        #
        # @raise [NotImplementedError]
        #   The class did not define a `model_name`.
        #
        # @example
        #   model_name 'Foo'
        #
        def self.model_name(new_model_name=nil)
          if new_model_name
            @model_name = new_model_name
          else
            @model_name ||= if superclass < ModelCommand
                              superclass.model_name
                            else
                              raise(NotImplementedError,"#{self} did not define model_name")
                            end
          end
        end

        option :add, value: {
                       type: String,
                       usage: 'VALUE'
                     },
                     desc: 'Adds a value to the database'

        option :import, value: {
                          type:  String,
                          usage: 'FILE'
                        },
                        desc: 'Imports the values from the FILE into the database'

        option :delete, value: {
                          type: String,
                          usage: 'VALUE'
                        },
                        desc: 'Deletes a value from the database'

        option :delete_all, desc: 'Deletes all values from the database'

        # The query method calls to chain together.
        #
        # @return [Array<(Symbol),
        #                (Symbol, Array),
        #                (Symbol, Hash),
        #                (Symbol, Array, Hash)>]
        attr_reader :query_method_calls

        #
        # Initializes the command.
        #
        # @param [Hash{Symbol => Object}] kwargs
        #   Additional keyword arguments.
        #
        def initialize(**kwargs)
          super(**kwargs)

          @query_method_calls = []
        end

        #
        # Runs the command.
        #
        def run
          connect
          load_model

          if options[:add]
            add(options[:add])
          elsif options[:import]
            import_file(options[:import])
          elsif options[:delete]
            delete(options[:delete])
          elsif options[:delete_all]
            delete_all
          else
            records = query
            records.each(&method(:print_record))
          end
        end

        #
        # Connects to the database, but not load the other models.
        #
        def connect
          DB.connect(config, load_models: false)
        end

        #
        # The model to query.
        #
        # @return [Class<ActiveRecord::Base>]
        #   The loaded model.
        #
        # @raise [LoadError]
        #   The {model_file} could not be loaded.
        #
        # @raise [NameError]
        #   The {model_name} was not found within {Ronin::DB}.
        #
        def load_model
          require self.class.model_file

          @model = Ronin::DB.const_get(self.class.model_name)
          @model.connection
          return @model
        end

        #
        # The model to query.
        #
        # @return [Class<ActiveRecord::Base>]
        #   The loaded model.
        #
        def model
          @model ||= load_model
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
            file.each_line(chomp: true) do |value|
              log_info "Importing #{value} ..." if verbose?

              add(value)
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

        #
        # Builds a new query by chaining together the method calls defined by
        # {#query_method_calls}.
        #
        # @return [ActiveRecord::Relation, ActiveRecord::QueryMethods::WhereChain]
        #   The new query.
        #
        def query
          common_object_methods = Object.public_instance_methods

          query = model.all

          @query_method_calls.each do |method,arguments,kwargs={}|
            if common_object_methods.include?(method)
              raise(ArgumentError,"cannot call method Object##{method} on query #{query.inspect}")
            end

            query = query.public_send(method,*arguments,**kwargs)
          end

          return query
        end

        #
        # Prints the given record.
        #
        # @param [ActiveRecord::Base] record
        #   The record to print.
        #
        def print_record(record)
          puts record
        end

      end
    end
  end
end
