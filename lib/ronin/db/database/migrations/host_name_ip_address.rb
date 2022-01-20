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
require 'ronin/db/database/migrations/address'

module Ronin
  module DB
    module Database
      module Migrations
        #
        # 1.0.0
        #
        migration :create_host_name_ip_addresses_table,
                  needs: :create_addresses_table do
          up do
            create_table :ronin_host_name_ip_addresses do
              column :id, Serial
              column :host_name_id, Integer, not_null: true
              column :ip_address_id, Integer, not_null: true
              column :created_at, Time, not_null: true
            end

            create_index :ronin_host_name_ip_addresses,
                         :host_name_id, :ip_address_id,
                         name:   :unique_index_ronin_host_name_ip_addresses,
                         unique: true
          end

          down do
            drop_table :ronin_host_name_ip_addresses
          end
        end
      end
    end
  end
end
