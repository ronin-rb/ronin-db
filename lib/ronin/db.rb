#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/db/exceptions'
require 'ronin/db/config_file'
require 'ronin/db/version'

module Ronin
  module DB
    #
    # Sets up the Database logger.
    #
    # @api semipublic
    #
    def self.logger=(new_logger)
      require 'active_record'
      ActiveRecord::Base.logger = new_logger
    end

    #
    # `ronin-db` database(s) configuration.
    #
    # @return [Hash{Symbol => Hash}]
    #
    # @api private
    #
    def self.config
      @config ||= ConfigFile.load
    end

    #
    # Migrate the database up and apply any pending migrations.
    #
    def self.migrate!
      require 'ronin/db/migrations'
      Migrations.migrate
    end

    #
    # Only migrate the database if the database is empty, otherwise warn the
    # user that there are pending migrations.
    #
    def self.migrate
      require 'ronin/db/migrations'

      if Migrations.current_version == 0
        # auto-run the migrations when the database is empty
        Migrations.migrate
      elsif Migrations.needs_migration?
        # warn the user that there are pending migrations, instead of
        # auto-running migrations each time
        warn "WARNING: Database requires migrating!"
      end
    end

    #
    # Connects to the Database.
    #
    # @param [Symbol, Hash] uri
    #   The optional default repository to setup instead of {repositories}.
    #
    # @param [Boolean] load_models
    #   Specifies whether to load all models or just connect to the database.
    #
    # @raise [UnknownDatabase]
    #
    # @raise [ArgumentError]
    #
    # @see Database.upgrade!
    #
    # @api semipublic
    #
    def self.connect(database=:default, migrate: nil, load_models: true)
      config = case database
               when Hash
                 database
               when Symbol
                 self.config.fetch(database) do
                   raise(UnknownDatabase,"unknown database: #{database.inspect}")
                 end
               else
                 raise(ArgumentError,"#{self.class}.#{__method__} only accepts a Symbol or a Hash")
               end

      # load activerecord
      require 'active_record'

      # connect to the database
      ActiveRecord::Base.establish_connection(config)

      # migrate the database if necessary
      if migrate == true then migrate!
      else                    migrate
      end

      if load_models
        # require and connect all models
        require 'ronin/db/models'
        Models.connect
      end

      return true
    end
  end
end
