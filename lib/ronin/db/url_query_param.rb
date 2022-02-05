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

require 'uri/query_params'

module Ronin
  module DB
    #
    # Represents a query param that belongs to a {URL}.
    #
    class URLQueryParam

      include Model

      # The primary-key of the URL query param
      property :id, Serial

      # The name of the URL query param
      belongs_to :name, model: 'URLQueryParamName'

      # The value of the URL query param
      property :value, Text

      # The URL
      belongs_to :url, model: 'URL'

      #
      # Converts the URL query param to a String.
      #
      # @return [String]
      #   The dumped URL query param.
      #
      # @since 1.0.0
      #
      # @api public
      #
      def to_s
        URI::QueryParams.dump(self.name.to_s => self.value)
      end

      #
      # Inspects the URL query param.
      #
      # @return [String]
      #   The inspected URL query param.
      #
      # @since 1.0.0
      #
      # @api public
      #
      def inspect
        "#<#{self.class}: #{self}>"
      end

    end
  end
end