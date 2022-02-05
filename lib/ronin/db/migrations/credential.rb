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

require 'ronin/db/migrations/migrations'
require 'ronin/db/migrations/user_name'
require 'ronin/db/migrations/password'
require 'ronin/db/migrations/open_port'
require 'ronin/db/migrations/proxy'

module Ronin
  module DB
    module Migrations
      #
      # 1.0.0
      #
      migration :create_credentials_table,
                needs: [
                  :create_user_names_table,
                  :create_passwords_table,
                  :create_open_ports_table,
                  :create_urls_table,
                  :create_proxies_table
                ] do
        up do
          create_table :ronin_credentials do
            column :id, Serial
            column :user_name_id, Integer, not_null: true
            column :password_id, Integer, not_null: true

            column :open_port_id, Integer
            column :email_address_id, Integer
            column :url_id, Integer
          end

          create_index :ronin_credentials,
                       :user_name_id, :password_id,
                       :open_port_id, :email_address_id, :url_id,
                       name:   :unique_index_ronin_credentials,
                       unique: true
        end

        down do
          drop_table :ronin_credentials
        end
      end
    end
  end
end
