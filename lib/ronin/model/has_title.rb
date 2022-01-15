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

require 'ronin/model'

module Ronin
  module Model
    #
    # Adds a `title` property to a model.
    #
    module HasTitle
      #
      # Adds the `title` property and {ClassMethods} to the model.
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
          # The title of the model
          property :title, String
        end
      end

      #
      # Class methods that are added when {HasTitle} are included into a
      # model.
      #
      module ClassMethods
        #
        # Finds models with titles containing a given fragment of text.
        #
        # @param [String] fragment
        #   The fragment of text to match titles with.
        #
        # @return [Array<Model>]
        #   The found models.
        #
        # @example
        #   Vuln.titled 'bypass'
        #
        # @api public
        #
        def titled(fragment)
          all(:title.like => "%#{fragment}%")
        end
      end
    end
  end
end
