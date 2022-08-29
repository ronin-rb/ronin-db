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

require 'ronin/db/exceptions'
require 'ronin/db/config_file'
require 'ronin/db/version'

require 'active_record'

module Ronin
  module DB
    #
    # Sets up the Database logger.
    #
    # @api semipublic
    #
    def self.logger=(new_logger)
      ActiveRecord::Base.logger = new_logger
    end

    #
    # @return [Hash{Symbol => Hash}]
    #
    def self.config
      @config ||= ConfigFile.load
    end

    #
    # Connects to the Database.
    #
    # @param [Symbol, Hash] uri
    #   The optional default repository to setup instead of {repositories}.
    #
    # @raise [UnknownDatabase]
    #
    # @raise [ArgumentError]
    #
    # @see Database.upgrade!
    #
    # @api semipublic
    #
    def self.connect(database=:default)
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

      # connect to the database
      ActiveRecord::Base.establish_connection(config)

      require 'ronin/db/migrations'

      if Migrations.current_version == 0
        # auto-run the migrations when the database is empty
        Migrations.migrate
      elsif Migrations.needs_migration?
        # warn the user that there are pending migrations, instead of
        # auto-running migrations each time
        warn "WARNING: Database requires migrating!"
      end

      # require all models
      require 'ronin/db/models'

      # connect the models
      Models.connect
      return true
    end
  end
end
