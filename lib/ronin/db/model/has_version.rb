#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-db.
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

require 'ronin/db/model'

module Ronin
  module DB
    module Model
      #
      # Adds a `version` property to a model.
      #
      module HasVersion
        #
        # Adds the `version` property and {ClassMethods} to the model.
        #
        # @param [Class] base
        #   The model.
        #
        # @api semipublic
        #
        def self.included(base)
          base.send :include, Model
          base.send :extend, ClassMethods

          base.module_eval do
            # The version of the model
            property :version, String, default: '0.1', index: true
          end
        end

        #
        # Class methods that are added when {HasVersion} is included into a
        # model.
        #
        module ClassMethods
          #
          # Finds all models with a specific version.
          #
          # @param [String] version
          #   The specific version to search for.
          #
          # @return [Array]
          #   The models with the specific version.
          #
          # @api public
          #
          def revision(version)
            all(version: version.to_s)
          end

          #
          # Finds latest version of the model.
          #
          # @api public
          #
          def latest
            first(order: [:version.desc])
          end
        end
      end
    end
  end
end