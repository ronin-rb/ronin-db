require 'ronin/database/migrations/migrations'
require 'ronin/database/migrations/ip_address'
require 'ronin/database/migrations/port'

module Ronin
  module Database
    module Migrations
      #
      # 1.0.0
      #
      migration :create_proxies_table,
                needs: [
                  :create_addresses_table,
                  :create_ports_table
                ] do
        up do
          create_table :ronin_proxies do
            column :id, Integer, serial: true
            column :type, String, not_null: true
            column :anonymous, Boolean, default: false
            column :latency, Float
            column :alive, Boolean, default: true
            column :ip_address_id, Integer, not_null: true
            column :port_id, Integer, not_null: true
            column :created_at, DateTime
            column :updated_at, DateTime
          end
        end

        down do
          drop_table :ronin_proxies
        end
      end
    end
  end
end
