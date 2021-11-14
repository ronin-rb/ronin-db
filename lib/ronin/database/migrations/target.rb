#
# Copyright (c) 2006-2012 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of Ronin.
#
# Ronin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ronin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ronin.  If not, see <http://www.gnu.org/licenses/>.
#

require 'ronin/database/migrations/migrations'
require 'ronin/database/migrations/campaign'
require 'ronin/database/migrations/address'

module Ronin
  module Database
    module Migrations
      #
      # 1.0.0
      #
      migration :create_targets_table,
                :needs => [
                  :create_campaigns_table,
                  :create_addresses_table
                ] do
        up do
          create_table :ronin_targets do
            column :id, Integer, :serial => true
            column :campaign_id, Integer, :not_null => true
            column :address_id, Integer, :not_null => true
          end

          create_index :ronin_targets, :campaign_id, :address_id,
                       :name => :unique_index_ronin_campaigns,
                       :unique => true
        end

        down do
          drop_table :ronin_targets
        end
      end

      #
      # 1.1.0
      #
      migration :add_created_at_column_to_targets_table,
                :needs => :create_targets_table do
        up do
          modify_table :ronin_targets do
            add_column :created_at, Time
          end

          require 'ronin/target'

          # set the updated_at column to the created_at of the Campaign
          Target.each do |target|
            target.update(:created_at => target.campaign.created_at)
          end
        end
      end
    end
  end
end
