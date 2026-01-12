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

require 'rake/tasklib'

module Ronin
  module DB
    #
    # Defines `ronin:db` tasks in a `Rakefile`.
    #
    # ## Example
    #
    #     require 'ronin/db/tasks'
    #     Ronin::DB::Tasks.new
    #
    class Tasks < Rake::TaskLib

      # The database to connect to.
      #
      # @return [Symbol, Hash]
      attr_reader :database

      #
      # Initializes the tasks.
      #
      # @param [Symbol, Hash] database
      #   The database name or Hash to connect to.
      #
      # @api public
      #
      def initialize(database: :default)
        super()

        @database = database

        define
      end

      #
      # Defines the `ronin:db` tasks.
      #
      # @api private
      #
      def define
        namespace :db do
          task :connect do
            require 'ronin/db'
            DB.connect(@database)
          end

          desc 'Migrates the development database'
          task :migrate => :connect do
            require 'ronin/db/migrations'
            DB::Migrations.up
          end

          desc 'Starts an interactive database console'
          task :console => :connect do
            require 'logger'
            DB.logger = Logger.new($stderr,:debug)

            require 'ronin/db/cli/ruby_shell'
            DB::CLI::RubyShell.start
          end
        end
      end

    end
  end
end
