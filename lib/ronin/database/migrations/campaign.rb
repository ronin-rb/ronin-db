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

require 'ronin/database/migrations/migrations'

module Ronin
  module Database
    module Migrations
      #
      # 1.0.0
      #
      migration :create_campaigns_table do
        up do
          create_table :ronin_campaigns do
            column :id, Integer, serial: true
            column :name, String, not_null: true
            column :description, Text, not_null: true
            column :created_at, Time
          end

          create_index :ronin_campaigns, :name, unique: true
        end

        down do
          drop_table :ronin_campaigns
        end
      end

      #
      # 1.1.0
      #
      migration :add_updated_at_column_to_campaigns_table,
                needs: :create_campaigns_table do
        up do
          modify_table :ronin_campaigns do
            add_column :updated_at, Time
          end

          adapter.execute('UPDATE ronin_campaigns SET updated_at=created_at')
        end

        down do
        end
      end
    end
  end
end
