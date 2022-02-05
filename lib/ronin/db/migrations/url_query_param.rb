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

require 'ronin/db/migrations'

module Ronin
  module DB
    module Migrations
      #
      # 1.0.0
      #
      migration :create_url_query_params_table do
        up do
          create_table :ronin_url_query_params do
            column :id, Integer, serial: true
            column :name, String, length: 256, not_null: true
            column :value, Text
            column :url_id, Integer, not_null: true
          end
        end

        down do
          drop_table :ronin_url_query_params
        end
      end
    end
  end
end