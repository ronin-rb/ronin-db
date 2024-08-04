# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2024 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative '../model_command'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Manages all PhoneNumbers in the database.
        #
        # ## Usage
        #
        #     ronin-db phone-numbers [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #     -v, --verbose                    Enables verbose output
        #     -t lfi|rfi|sqli|ssti|open-redirect|reflected-xss|command-injection,
        #         --with-type                  Searches for all web vulns of the given type
        #     -H, --for-host HOST              Searches for web vulns effecting the host
        #     -d, --for-domain DOMAIN          Searches for web vulns effecting the domain
        #     -p, --for-path PATH              Searches for web vulns effecting the given path
        #     -q, --with-query-param NAME      Searches for web vulns effecting the query param name
        #         --with-header-name NAME      Searches for web vulns effecting the HTTP header name
        #     -c, --with-cookie-param NAME     Searches for web vulns effecting the cookie param name
        #     -f, --with-form-param NAME       Searches for web vulns effecting the form param name
        #     -M HTTP_METHOD,                  Searches for all web vulns with the HTTP request method
        #         --with-request-method
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class WebVulns < ModelCommand

          command_name 'web-vulns'

          model_file 'ronin/db/web_vuln'
          model_name 'WebVuln'

          option :with_type, short: '-t',
                             value: {
                               type: {
                                 lfi:               'lfi',
                                 rfi:               'rfi',
                                 sqli:              'sqli',
                                 ssti:              'ssti',

                                 :"open-redirect"     => 'open_redirect',
                                 :"reflected-xss"     => 'reflected_xss',
                                 :"command-injection" => 'command_injection'
                               }
                             },
                             desc: 'Searches for all web vulns of the given type' do |type|
                               @query_method_calls << [:with_type, type]
                             end

          option :for_host, short: '-H',
                            value: {
                              type:  String,
                              usage: 'HOST'
                            },
                            desc: 'Searches for web vulns effecting the host' do |host|
                              @query_method_calls << [:for_host, host]
                            end

          option :for_domain, short: '-d',
                              value: {
                                type:  String,
                                usage: 'DOMAIN'
                              },
                              desc: 'Searches for web vulns effecting the domain' do |domain|
                                @query_method_calls << [:for_domain, domain]
                              end

          option :for_path, short: '-p',
                            value: {
                              type:  String,
                              usage: 'PATH'
                            },
                            desc: 'Searches for web vulns effecting the given path' do |path|
                              @query_method_calls << [:for_path, path]
                            end

          option :with_query_param, short: '-q',
                                    value: {
                                      type:  String,
                                      usage: 'NAME'
                                    },
                                    desc: 'Searches for web vulns effecting the query param name' do |name|
                                      @query_method_calls << [:with_query_param, name]
                                    end

          option :with_header_name, value: {
                                      type:  String,
                                      usage: 'NAME'
                                    },
                                    desc: 'Searches for web vulns effecting the HTTP header name' do |name|
                                      @query_method_calls << [:with_header_name, name]
                                    end

          option :with_cookie_param, short: '-c',
                                    value: {
                                      type:  String,
                                      usage: 'NAME'
                                    },
                                    desc: 'Searches for web vulns effecting the cookie param name' do |name|
                                      @query_method_calls << [:with_cookie_param, name]
                                    end

          option :with_form_param, short: '-f',
                                    value: {
                                      type:  String,
                                      usage: 'NAME'
                                    },
                                    desc: 'Searches for web vulns effecting the form param name' do |name|
                                      @query_method_calls << [:with_form_param, name]
                                    end

          option :with_request_method, short: '-M',
                                       value: {
                                         type: {
                                           'COPY'      => :copy,
                                           'DELETE'    => :delete,
                                           'GET'       => :get,
                                           'HEAD'      => :head,
                                           'LOCK'      => :lock,
                                           'MKCOL'     => :mkcol,
                                           'MOVE'      => :move,
                                           'OPTIONS'   => :options,
                                           'PATCH'     => :patch,
                                           'POST'      => :post,
                                           'PROPFIND'  => :propfind,
                                           'PROPPATCH' => :proppatch,
                                           'PUT'       => :put,
                                           'TRACE'     => :trace,
                                           'UNLOCK'    => :unlock
                                         },
                                         usage: 'HTTP_METHOD'
                                       },
                                       desc: 'Searches for all web vulns with the HTTP request method' do |http_method|
                                         @query_method_calls << [:with_request_method, http_method]
                                       end

          description 'Queries and manages WebVulns'

          man_page 'ronin-db-web-vulns.1'

          # Mapping of web vulnerability types and their printable names.
          TYPE_NAMES = {
            'lfi'  => 'LFI',
            'rfi'  => 'RFI',
            'sqli' => 'SQLi',
            'ssti' => 'SSTI',

            'open_redirect'     => 'Open Redirect',
            'reflected_xss'     => 'Reflected XSS',
            'command_injection' => 'Command Injection'
          }

          #
          # Returns the printable vulnerability type for the vulnerability.
          #
          # @param [Ronin::DB::WebVuln] web_vuln
          #
          # @return [String]
          #
          def web_vuln_type(web_vuln)
            TYPE_NAMES.fetch(web_vuln.type) do
              raise(NotImplementedError,"unknown web vulnerability type: #{web_vuln.type.inspect}")
            end
          end

          #
          # Determines the location of the web vulnerability.
          #
          # @param [Ronin::DB::WebVuln] web_vuln
          #
          # @return [String, nil]
          #
          def web_vuln_location(web_vuln)
            if web_vuln.query_param
              "query param '#{web_vuln.query_param}'"
            elsif web_vuln.header_name
              "Header '#{web_vuln.header_name}'"
            elsif web_vuln.cookie_param
              "Cookie param '#{web_vuln.cookie_param}'"
            elsif web_vuln.form_param
              "form param '#{web_vuln.form_param}'"
            end
          end

          #
          # Prints a web vulnerability record from the database.
          #
          # @param [Ronin::DB::WebVuln] web_vuln
          #   The web vulnerability record to print.
          #
          def print_record(web_vuln)
            type     = web_vuln_type(web_vuln)
            location = web_vuln_location(web_vuln)

            if location
              puts "#{type} on #{web_vuln.url} via #{location}"
            else
              puts "#{type} on #{web_vuln.url}"
            end
          end

        end
      end
    end
  end
end
