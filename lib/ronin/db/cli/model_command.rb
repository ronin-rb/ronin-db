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
        # Sets or gets the model name to lookup.
        #
        # @param [String, nil] new_model_name
        #   The new model name.
        #
        # @return [String]
        #   The model name to lookup.
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
          list
        end

        #
        # Connects to the database.
        #
        def connect
          # connect to the database but do not load other models.
          DB.connect(config, load_models: false)

          # load and connect the model
          model.connection
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

          Ronin::DB.const_get(self.class.model_name)
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
        # Queries and lists records.
        #
        def list
          records = query
          records.each(&method(:print_record))
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
