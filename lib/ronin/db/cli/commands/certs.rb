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

require 'ronin/db/cli/model_command'

require 'command_kit/printing/indent'
require 'command_kit/printing/fields'
require 'command_kit/printing/lists'

module Ronin
  module DB
    class CLI
      module Commands
        #
        # Queries or imports SSL/TLS certificates.
        #
        # ## Usage
        #
        #     ronin-db asn [options]
        #
        # ## Options
        #
        #         --db NAME                    The database to connect to (Default: default)
        #         --db-uri URI                 The database URI to connect to
        #         --db-file PATH               The sqlite3 database file to use
        #     -v, --verbose                    Enables verbose output
        #     -A, --active                     Searches for all Certs that are active
        #     -E, --expired                    Searches for all Certs that are expired
        #         --issuer-common-name NAME    Searches for all Certs with the Issuer Common Name (CN)
        #         --issuer-organization NAME   Searches for all Certs with the Issuer Organization (O)
        #         --issuer-organizational-unit NAME
        #                                      Searches for all Certs with the Issuer Organizational Unit (OU)
        #         --issuer-locality LOCALITY   Searches for all Certs with the Issuer Locality (L)
        #         --issuer-state STATE         Searches for all Certs with the Issuer State (ST)
        #         --issuer-country COUNTRY     Searches for all Certs with the Issuer Country (C)
        #         --common-name HOST           Searches for all Certs with the Subject Common Name (CN)
        #         --subject-alt-name HOST      Searches for all Certs with the Subject Alternative Name (SAN)
        #         --organization NAME          Searches for all Certs with the Subject Organization (O)
        #         --organizational-unit NAME   Searches for all Certs with the Subject Organizational Unit (OU)
        #         --locality LOCALITY          Searches for all Certs with the Subject Locality (L)
        #         --state STATE                Searches for all Certs with the Subject State (ST)
        #         --country COUNTRY            Searches for all Certs with the Subject Country (C)
        #         --import FILE                Imports a Cert from a file
        #     -h, --help                       Print help information
        #
        # @since 0.2.0
        #
        class Certs < ModelCommand

          include CommandKit::Printing::Indent
          include CommandKit::Printing::Fields
          include CommandKit::Printing::Lists

          model_file 'ronin/db/cert'
          model_name 'Cert'

          option :active, short: '-A',
                          desc:  'Searches for all Certs that are active' do
                            @query_method_calls << [:active]
                          end

          option :expired, short: '-E',
                           desc:  'Searches for all Certs that are expired' do
                             @query_method_calls << [:expired]
                           end

          option :issuer_common_name, value: {
                                        type:  String,
                                        usage: 'NAME'
                                      },
                                      desc: 'Searches for all Certs with the Issuer Common Name (CN)' do |name|
                                        @query_method_calls << [:with_issuer_common_name, [name]]
                                      end

          option :issuer_organization, value: {
                                         type:  String,
                                         usage: 'NAME'
                                       },
                                       desc: 'Searches for all Certs with the Issuer Organization (O)' do |name|
                                         @query_method_calls << [:with_issuer_organization, [name]]
                                       end

          option :issuer_organizational_unit, value: {
                                                type:  String,
                                                usage: 'NAME'
                                              },
                                              desc: 'Searches for all Certs with the Issuer Organizational Unit (OU)' do |name|
                                                @query_method_calls << [:with_issuer_organizational_unit, [name]]
                                              end

          option :issuer_locality, value: {
                                     type:  String,
                                     usage: 'LOCALITY'
                                   },
                                   desc: 'Searches for all Certs with the Issuer Locality (L)' do |locality|
                                     @query_method_calls << [:with_issuer_locality, [locality]]
                                   end

          option :issuer_state, value: {
                                  type:  String,
                                  usage: 'STATE'
                                },
                                desc: 'Searches for all Certs with the Issuer State (ST)' do |state|
                                  @query_method_calls << [:with_issuer_state, [state]]
                                end

          option :issuer_country, value: {
                                    type:  String,
                                    usage: 'COUNTRY'
                                  },
                                  desc: 'Searches for all Certs with the Issuer Country (C)' do |country|
                                    @query_method_calls << [:with_issuer_country, [country]]
                                  end

          option :common_name, value: {
                                 type:  String,
                                 usage: 'HOST'
                               },
                               desc: 'Searches for all Certs with the Subject Common Name (CN)' do |host|
                                 @query_method_calls << [:with_common_name, [host]]
                               end

          option :subject_alt_name, value: {
                                      type:  String,
                                      usage: 'HOST'
                                    },
                                    desc: 'Searches for all Certs with the Subject Alternative Name (SAN)' do |host|
                                      @query_method_calls << [:with_subject_alt_name, [host]]
                                    end

          option :organization, value: {
                                  type:  String,
                                  usage: 'NAME'
                                },
                                desc: 'Searches for all Certs with the Subject Organization (O)' do |name|
                                  @query_method_calls << [:with_organization, [name]]
                                end

          option :organizational_unit, value: {
                                         type:  String,
                                         usage: 'NAME'
                                       },
                                       desc: 'Searches for all Certs with the Subject Organizational Unit (OU)' do |name|
                                         @query_method_calls << [:with_organizational_unit, [name]]
                                       end

          option :locality, value: {
                              type:  String,
                              usage: 'LOCALITY'
                            },
                            desc: 'Searches for all Certs with the Subject Locality (L)' do |locality|
                              @query_method_calls << [:with_locality, [locality]]
                            end

          option :state, value: {
                           type:  String,
                           usage: 'STATE'
                         },
                         desc: 'Searches for all Certs with the Subject State (ST)' do |state|
                           @query_method_calls << [:with_state, [state]]
                         end

          option :country, value: {
                             type:  String,
                             usage: 'COUNTRY'
                           },
                           desc: 'Searches for all Certs with the Subject Country (C)' do |country|
                             @query_method_calls << [:with_country, [country]]
                           end

          option :import, value: {
                            type:  String,
                            usage: 'FILE'
                          },
                          desc: 'Imports a Cert from a file'

          description 'Queries or imports SSL/TLS certificates'

          man_page 'ronin-db-certs.1'

          #
          # Runs the `ronin-db certs` command.
          #
          def run
            db_connect

            if options[:import]
              import_cert(options[:import])
            else
              list
            end
          end

          #
          # Imports a certificate from a file.
          #
          # @param [String] path
          #   The path to the certificate file.
          #
          def import_cert(path)
            unless File.file?(path)
              print_error "no such file or directory: #{path}"
              exit(-1)
            end

            cert = begin
                     Ronin::Support::Crypto::Cert.load_file(path)
                   rescue OpenSSL::X509::CertificateError
                     print_error "cannot parse the certificate file: #{path}"
                     exit(-1)
                   end

            model.find_or_import(cert)
          end

          #
          # Prints a certificate record.
          #
          # @param [Ronin::DB::Cert] cert
          #   The certificate record to print.
          #
          def print_record(cert)
            puts "[ #{cert.subject.common_name} ]"
            puts

            indent do
              print_fields(
                "Serial"     => cert.serial,
                "Not Before" => cert.not_before,
                "Not After"  => cert.not_after
              )
              puts

              puts "Subject:"
              indent { print_cert_org(cert.subject) }
              puts

              unless cert.subject_alt_names.empty?
                puts "Subject Alt Names:"
                indent { print_list(cert.subject_alt_names) }
                puts
              end

              if cert.issuer
                puts "Issuer:"
                indent { print_cert_org(cert.issuer) }
                puts
              end

              print_fields(
                'Public Key Algorithm' => cert.public_key_algorithm.upcase,
                'Public Key Size'      => cert.public_key_size,
                'Signing Algorithm'    => cert.signing_algorithm,
                'SHA1 Fingerprint'     => cert.sha1_fingerprint,
                'SHA256 Fingerprint'   => cert.sha256_fingerprint
              )
            end
            puts
          end

          #
          # Prints a certificate Subject or Issuer.
          #
          # @param [Ronin::DB::CertSubject, Ronin::DB::CertIssuer] cert_org
          #   The Subject or Issuer to print.
          #
          def print_cert_org(cert_org)
            fields = {}

            if cert_org.common_name
              fields['Common Name (CN)'] = cert_org.common_name
            end

            if cert_org.email_address
              fields['Email address'] = cert_org.email_address
            end

            if cert_org.organization
              fields['Organization (O)'] = cert_org.organization
            end

            if cert_org.organizational_unit
              fields['Organization Unit (OU)'] = cert_org.organizational_unit
            end

            if cert_org.locality
              fields['Locality (L)'] = cert_org.locality
            end

            if cert_org.state
              fields['State (ST)'] = cert_org.state
            end

            if cert_org.country
              fields['Country (C)'] = cert_org.country
            end

            print_fields(fields)
          end

        end
      end
    end
  end
end
