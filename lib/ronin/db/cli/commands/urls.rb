# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2023 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/db/cli/model_command'
require 'ronin/db/cli/modifiable'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages all URLs in the database.
        #
        # ## Usage
        #
        #     ronin-db urls [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #     -v, --verbose                    Enables verbose output
        #         --add VALUE                  Adds a value to the database
        #         --import FILE                Imports the values from the FILE into the database
        #         --delete VALUE               Deletes a value from the database
        #         --delete-all                 Deletes all values from the database
        #          --http
        #          --https
        #      -H, --host HOST
        #      -P, --port PORT
        #      -d, --directory SUBDIR
        #      -E, --ext EXT
        #      -q NAME
        #          --with-query-param
        #      -Q VALUE
        #          --with-query-value
        #
        class Urls < ModelCommand

          include Modifiable

          model_file 'ronin/db/url'
          model_name 'URL'

          option :http, desc: 'Searches for http:// URLs' do
            @query_method_calls << :http
          end

          option :https, desc: 'Searches for https:// URLs' do
            @query_method_calls << :https
          end

          option :host, short: '-H',
                        value: {
                          type: String,
                          usage: 'HOST'
                        },
                        desc: 'Searches for the associated HOST(s)' do |host|
                          @query_method_calls << [:with_host_name, [host]]
                        end

          option :port, short: '-p',
                        value: {
                          type: Integer,
                          usage: 'PORT'
                        },
                        desc: 'Searches for the associated PORT(s)' do |port|
                          @query_method_calls << [:with_port_number, [port]]
                        end

          option :path, value: {
                          type: String,
                          usage: 'PATH'
                        },
                        desc: 'Searches for all URLs with the PATH' do |path|
                          @query_method_calls << [:where, [], {path: path}]
                        end

          option :fragment, value: {
                              type: String,
                              usage: 'FRAGMENT'
                            },
                            desc: 'Searches for all URLs with the FRAGMENT' do |fragment|
                              @query_method_calls << [:where, [], {fragment: fragment}]
                            end

          option :directory, short: '-d',
                             value: {
                               type:  String,
                               usage: 'DIR'
                             },
                             desc: 'Searches for the associated DIR' do |dir|
                               @query_method_calls << [:with_directory, [dir]]
                             end

          option :with_ext, short: '-E',
                            value: {
                              type:  String,
                              usage: 'EXT'
                            },
                            desc: 'Searches for URLs with the file extension' do |ext|
                              @query_method_calls << [:with_ext, [ext]]
                            end

          option :query_string, short: '-q',
                                value: {
                                  type:  String,
                                  usage: 'STRING',
                                },
                                desc: 'Searches for all URLs with the query string' do |string|
                                  @query_method_calls << [:where, [], {query: string}]
                                end

          option :with_query_param, short: '-P',
                                    value: {
                                      type: String,
                                      usage: 'NAME[=VALUE]'
                                    },
                                    desc: 'Searches for the associated query-param NAME(s)' do |string|
                                      name, value = string.split('=',2)

                                      if value
                                        @query_method_calls << [:with_query_param, [name, value]]
                                      else
                                        @query_method_calls << [:with_query_param_name, [name]]
                                      end
                                    end

          option :with_query_param_name, value: {
                                           type:  String,
                                           usage: 'NAME'
                                         },
                                         desc: 'Searches for the associated query-param VALUE(s)' do |name|
                                           @query_method_calls << [:with_query_param_name, [name]]
                                         end

          option :with_query_param_value, value: {
                                            type:  String,
                                            usage: 'VALUE'
                                          },
                                          desc: 'Searches for the associated query-param VALUE(s)' do |value|
                                            @query_method_calls << [:with_query_param_value, [value]]
                                          end

          description 'Manages URLs'

          man_page 'ronin-db-urls.1'

        end
      end
    end
  end
end
