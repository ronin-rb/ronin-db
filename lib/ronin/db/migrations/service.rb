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
require 'ronin/db/migrations/organization'

module Ronin
  module DB
    module Migrations
      #
      # 1.0.0
      #
      migration :create_services_table, needs: :create_organizations_table do
        up do
          create_table :ronin_services do
            column :id, Integer, serial: true
            column :name, String, not_null: true
            column :organization_id, Integer
          end

          create_index :ronin_services, :name, unique: true
        end

        down do
          drop_table :ronin_services
        end
      end

      #
      # 1.6.0
      #
      migration :add_protocol_to_services_table do
        up do
          modify_table :ronin_services do
            add_column :protocol, String
          end

          create_index :ronin_services, :protocol
        end

        down do
        end
      end
    end
  end
end