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

require 'ronin/db/database/migrations/migrations'

module Ronin
  module DB
    module Database
      module Migrations
        #
        # 1.0.0
        #
        migration :create_countries_table do
          up do
            create_table :ronin_countries do
              column :id, Integer, serial: true
              column :name, String, not_null: true
              column :code, String, length: 2, not_null: true
            end

            create_index :ronin_countries, :name, unique: true
            create_index :ronin_countries, :code, unique: true
          end

          down do
            drop_table :ronin_countries
          end
        end
      end
    end
  end
end
