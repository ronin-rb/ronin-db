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

require 'ronin/ui/cli/model_command'
require 'ronin/db/model/importable'

require 'dm-serializer'

module Ronin
  module DB
    module CLI
      #
      # A base-command class for listing Database Resources.
      #
      class ResourcesCommand < ModelCommand

        option :csv, type:        true,
                     description: 'CSV output'

        option :xml, type:        true,
                     description: 'XML output'

        option :yaml, type:        true,
                      description: 'YAML output'

        option :json, type:        true,
                      description: 'JSON output'

        #
        # Default method performs the query and prints the found resources.
        #
        # @since 1.1.0
        #
        # @api semipublic
        #
        def execute
          if @import
            self.class.model.import(@import) do |resource|
              print_info "Imported #{resource}"
            end
          else
            print_resources(query)
          end
        end

        #
        # Sets the model used by the command.
        #
        # @see ModelCommand.model
        #
        # @since 1.3.0
        #
        def self.model(model=nil)
          if (model && model < Model::Importable)
            option :import, type:        String,
                            flag:        '-i',
                            usage:       'FILE',
                            description: 'The file to import'
          end

          return super(model)
        end

        #
        # Default method which will print every queried resource.
        #
        # @param [DataMapper::Resource] resource
        #   A queried resource from the Database.
        #
        # @since 1.1.0
        #
        # @api semipublic
        #
        def print_resource(resource)
          puts resource
        end

        #
        # Prints multiple resources.
        #
        # @param [DataMapper::Collection] resources
        #   The query to print.
        #
        # @since 1.1.0
        #
        # @api semipublic
        #
        def print_resources(resources)
          if    csv?  then puts resources.to_csv
          elsif xml?  then puts resources.to_xml
          elsif yaml? then puts resources.to_yaml
          elsif json? then puts resources.to_json
          else
            resources.each { |resource| print_resource(resource) }
          end
        end

      end
    end
  end
end
