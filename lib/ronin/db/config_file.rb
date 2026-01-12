# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative 'exceptions'
require_relative 'home'

require 'fileutils'
require 'yaml'
require 'yaml/store'

module Ronin
  module DB
    #
    # Represents the `~/.config/ronin-db/databases.yml` configuration file.
    #
    # @api private
    #
    module ConfigFile
      # Path to the `~/.config/ronin-db/databases.yml` configuration file.
      PATH = File.join(DB::Home::CONFIG_DIR,'databases.yml')

      # Path to the default sqlite3 database file
      # (`~/.local/share/ronin-db/default.sqlite3`).
      DEFAULT_DB_FILE = File.join(DB::Home::LOCAL_SHARE_DIR,'default.sqlite3')

      # Default database configuration.
      DEFAULT_CONFIG = {
        default: {
          adapter: 'sqlite3',
          database: DEFAULT_DB_FILE
        }
      }

      #
      # Validates the loaded configuration data from the given path.
      #
      # @param [String] path
      #   The path the configuration data was loaded from.
      #
      # @param [Object] data
      #   The loaded configuration data.
      #
      # @raise [InvalidConfig]
      #   The configuration data is not a Hash, does not contain Symbol keys,
      #   or does not contain Hashes.
      #
      # @return [true]
      #   The configuration data is valid.
      #
      def self.validate(path,data)
        unless data.kind_of?(Hash)
          raise(InvalidConfig,"config data must be a Hash: #{data.inspect}")
        end

        data.each do |key,value|
          unless key.kind_of?(Symbol)
            raise(InvalidConfig,"all Hash keys must be a Symbol: #{key.inspect}")
          end

          unless value.kind_of?(Hash)
            raise(InvalidConfig,"all Hash values must also be a Hash: #{value.inspect}")
          end

          value.each_key do |sub_key|
            unless sub_key.kind_of?(Symbol)
              raise(InvalidConfig,"all sub-keys must be a Symbol: #{sub_key.inspect}")
            end
          end
        end

        return true
      end

      #
      # Loads configuration data from the given path.
      #
      # @param [String] path
      #   The path to the configuration file.
      #
      # @return [Hash{Symbol => Hash}]
      #   The loaded configuration data.
      #
      # @raise [InvalidConfig]
      #   The configuration data is not a Hash, does not contain Symbol keys,
      #   or does not contain Hashes.
      #
      def self.load(path=PATH)
        if File.file?(path)
          config = YAML.load_file(path, symbolize_names: true).tap do |data|
            validate(path,data)
          end

          DEFAULT_CONFIG.merge(config)
        else
          DEFAULT_CONFIG
        end
      end

      #
      # Opens the configuration file and edits it's contents.
      #
      # @yield [yaml]
      #   The given block will be given the loaded configuration data.
      #   Once the block has returned, the YAML configuration data will be
      #   written back to the file.
      #
      # @yieldparam [YAML::Store] yaml
      #   The loaded YAML configuration data.
      #
      def self.edit(path=PATH,&block)
        unless File.file?(path)
          # create the parent directory for YAML::Store
          FileUtils.mkdir_p(File.dirname(path))
        end

        store = YAML::Store.new(path)
        store.transaction(&block)
      end
    end
  end
end
