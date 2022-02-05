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
require 'ronin/db/migrations/ip_address'
require 'ronin/db/migrations/port'

module Ronin
  module DB
    module Migrations
      #
      # 1.0.0
      #
      migration :create_open_ports_table,
                needs: [
                  :create_addresses_table,
                  :create_ports_table,
                ] do
        up do
          create_table :ronin_open_ports do
            column :id, Integer, serial: true
            column :ip_address_id, Integer, not_null: true
            column :port_id, Integer, not_null: true
            column :service_id, Integer
            column :last_scanned_at, Time
            column :created_at, Time, not_null: true
          end

          create_index :ronin_open_ports,
                       :ip_address_id, :port_id, :service_id,
                       name:   :unique_index_ronin_open_ports,
                       unique: true
        end

        down do
          drop_table :ronin_open_ports
        end
      end

      #
      # 1.6.0
      #
      migration :add_software_id_to_open_ports_table,
                needs: :create_open_ports_table do
        up do
          modify_table :ronin_open_ports do
            add_column :software_id, Integer
          end
        end

        down do
        end
      end

      migration :add_ssl_to_open_ports_table,
                needs: :create_open_ports_table do
        up do
          modify_table :ronin_open_ports do
            add_column :ssl, Boolean
          end
        end

        down do
        end
      end

    end
  end
end
