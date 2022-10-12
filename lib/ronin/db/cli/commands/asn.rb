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

require 'ronin/db/cli/model_command'
require 'ronin/core/cli/logging'

require 'ronin/support/network/asn'
require 'ronin/support/network/asn/list'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Queries and updates ASNs.
        #
        # ## Usage
        #
        #     ronin-db asn [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #     -v, --verbose                    Enables verbose output
        #     -n, --number INT                 Searches for all ASN records with the AS number
        #     -C XX|None|Uknown,               Searches for all ASN records with the country code
        #         --country-code
        #     -N, --name NAME                  Searches for all ASN records with the matching name
        #     -I, --ip IP                      Queries the ASN record for the IP
        #     -4, --ipv4                       Filter ASN records for only IPv4 ranges
        #     -6, --ipv6                       Filter ASN records for only IPv6 ranges
        #     -u, --update                     Updates the ASN records
        #     -U, --url URI                    Overrides the default ASN list URL (Default: https://iptoasn.com/data/ip2asn-combined.tsv.gz)
        #     -f, --file FILE                  Overrides the default ASN list file (Default: /home/postmodern/.local/share/ronin/ronin-support/ip2asn-combined.tsv.gz)
        #     -h, --help                       Print help information
        #
        class Asn < ModelCommand

          include Core::CLI::Logging

          model_file 'ronin/db/asn'
          model_name 'ASN'

          option :number, short: '-n',
                          value: {
                            type: Integer,
                          },
                          desc: 'Searches for all ASN records with the AS number' do |number|
                            @query_method_calls << [:with_number, [number]]
                          end

          option :country_code, short: '-C',
                                value: {
                                  type:  /[A-Z]{2}|None|Unknown/,
                                  usage: 'XX|None|Uknown'
                                },
                                desc: 'Searches for all ASN records with the country code' do |cc|
                                  @query_method_calls << [:with_country_code, [cc]]
                                end

          option :name, short: '-N',
                        value: {
                          type:  String,
                          usage: 'NAME'
                        },
                        desc: 'Searches for all ASN records with the matching name' do |name|
                          @query_method_calls << [:with_name, [name]]
                        end

          option :ip, short: '-I',
                      value: {
                        type:  String,
                        usage: 'IP'
                      },
                      desc: 'Queries the ASN record for the IP' do |ip|
                        @query_method_calls << [:containing_ip, [ip]]
                      end

          option :ipv4, short: '-4',
                        desc: 'Filter ASN records for only IPv4 ranges' do
                          @query_method_calls << [:v4]
                        end

          option :ipv6, short: '-6',
                        desc: 'Filter ASN records for only IPv6 ranges' do
                          @query_method_calls << [:v6]
                        end

          option :update, short: '-u',
                          desc: 'Updates the ASN records'

          option :url, short: '-U',
                       value: {
                         type:    String,
                         usage:   'URI',
                         default: Support::Network::ASN::List::URL
                       },
                       desc: 'Overrides the default ASN list URL'

          option :file, short: '-f',
                        value: {
                          type:    String,
                          usage:   'FILE',
                          default: Support::Network::ASN::List::PATH
                        },
                        desc: 'Overrides the default ASN list file'

          description 'Queries and updates ASNs'

          man_page 'ronin-db-asn.1'

          #
          # Runs the `ronin-db asn` command.
          #
          def run
            connect

            if options[:update]
              update
            else
              list
            end
          end

          #
          # Updates the ASN file and populates the database.
          #
          def update
            if is_list_file_stale?
              log_info "Updating ASN list file ..."
              update_list_file
            end

            # clear the table instead of trying to diff the list with the table
            model.delete_all

            model.transaction do
              parse_list_file do |record|
                log_info "Importing #{record} ..."
                import_asn_record(record)
              end
            end
          end

          #
          # Determines if the ASN list file is stale.
          #
          def is_list_file_stale?
            Support::Network::ASN::List.stale?(options[:file])
          end

          #
          # Updates the ASN list file.
          #
          def update_list_file
            Support::Network::ASN::List.update(
              path: options[:file],
              url:  options[:url]
            )
          end

          #
          # Parses the ASN list file.
          #
          # @yield [record]
          #
          # @yieldparam [Ronin::Support::Network::ASN::Record] record
          #
          # @return [Enumerator]
          #
          def parse_list_file(&block)
            Support::Network::ASN::List.parse(options[:file],&block)
          end

          #
          # Saves a parsed ASN record.
          #
          # @param [Ronin::Support::Network::ASN::Record] record
          #
          def import_asn_record(record)
            asn = model.new(
              version: if record.ipv6? then 6
                       else                 4
                       end,
              range_start:  record.range.begin,
              range_end:    record.range.end,
              number:       record.number,
              country_code: record.country_code,
              name:         record.name
            )

            # bypass validations since we're importing from a known good source
            asn.save(validate: false)
          end

        end
      end
    end
  end
end
