# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative '../command'
require_relative '../uri_methods'
require_relative '../../config_file'

require 'command_kit/options/verbose'
require 'command_kit/printing'
require 'command_kit/printing/indent'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Adds an existing database to the `~/.config/ronin-db/database.yml`
        # configuration file.
        #
        # ## Usage
        #
        #     ronin-db add [options] NAME [URI]
        #
        # ## Options
        #
        #     -A sqlite3|mysql2|postgresql|...,
        #         --adapter                    The database adapter
        #         --sqlite3 FILE               Alias for --adapter sqlite3 --database FILE
        #         --mysql2                     Alias for --adapter mysql2
        #         --postgresql                 Alias for --adapter postgresql
        #     -H, --host HOST                  The host of the database to add
        #     -p, --port PORT                  The port of the database to add
        #     -u, --username USER              The user to authenticate with for the database
        #     -P, --password PASSWORD          The password to authenticate with for the database
        #         --read-password              Reads the database password from stdin
        #     -D, --database NAME|PATH         The database name or path (for sqlite3)
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     NAME                             The name of the database to add.
        #     [URI]                            The optional URI to the database.
        #
        class Add < Command

          include URIMethods

          usage '[options] NAME [URI]'

          option :adapter, short: '-A',
                           value: {
                             type:  String,
                             usage: 'sqlite3|mysql2|postgresql|...'
                           },
                           desc: 'The database adapter' do |adapter|
                             @config[:adapter] = normalize_adapter(adapter)
                           end

          option :sqlite3, value: {
                             type: String,
                             usage: 'FILE'
                           },
                           desc: 'Alias for --adapter sqlite3 --database FILE' do |file|
                             @config[:adapter]  = 'sqlite3'
                             @config[:database] = normalize_sqlite3_path(file)
                           end

          option :mysql2, desc: 'Alias for --adapter mysql2' do
            @config[:adapter] = 'mysql2'
          end

          option :postgresql, desc: 'Alias for --adapter postgresql' do
            @config[:adapter] = 'postgresql'
          end

          option :host, short: '-H',
                        value: {
                          type: String,
                          usage: 'HOST'
                        },
                        desc: 'The host of the database to add' do |host|
                          @config[:host] = host
                        end

          option :port, short: '-p',
                        value: {
                          type: Integer,
                          usage: 'PORT'
                        },
                        desc: 'The port of the database to add' do |port|
                          @config[:port] = port
                        end

          option :username, short: '-u',
                            value: {
                              type: String,
                              usage: 'USER'
                            },
                            desc: 'The user to authenticate with for the database' do |user|
                              @config[:username] = user
                            end

          option :password, short: '-P',
                            value: {
                              type: String,
                              usage: 'PASSWORD'
                            },
                            desc: 'The password to authenticate with for the database' do |password|
                              @config[:password] = password
                            end

          option :read_password, desc: 'Reads the database password from stdin'

          option :database, short: '-D',
                            value: {
                              type: String,
                              usage: 'NAME|PATH'
                            },
                            desc: 'The database name or path (for sqlite3)' do |database|
                              @config[:database] = database
                            end

          argument :name, desc: 'The name of the database to add'

          argument :uri, required: false,
                         desc:     'The optional URI to the database'

          description 'Adds a pre-existing database to ronin-db'

          man_page 'ronin-db-add.1'

          # The database configuration Hash to add.
          #
          # @return [Hash{Symbol => Object}]
          attr_reader :config

          #
          # Initializes the command.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments.
          #
          def initialize(**kwargs)
            super(**kwargs)

            @config = {}
          end

          #
          # Runs the `ronin-db add` command.
          #
          def run(name,uri=nil)
            @config = parse_uri(uri) if uri

            read_password if options[:read_password]
            validate_config!

            ConfigFile.edit do |yaml|
              yaml[name] = @config
            end
          end

          #
          # Reads the password from stdin and sets `config[:password]`.
          #
          def read_password
            @config[:password] = ask_secret('Password')
          end

          #
          # Validates the {#config} Hash.
          #
          def validate_config!
            unless @config[:adapter]
              print_error "must specify a URI or the --adapter option"
              exit(1)
            end

            unless @config[:database]
              print_error "must specify a URI or the --database option"
              exit(1)
            end
          end

        end
      end
    end
  end
end
