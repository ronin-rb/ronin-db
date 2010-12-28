#
# Ronin - A Ruby platform for exploit development and security research.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/ui/cli/model_command'
require 'ronin/url'

module Ronin
  module UI
    module CLI
      module Commands
        #
        # The `ronin-urls` command.
        #
        class URLs < ModelCommand

          self.model = Ronin::URL

          query_option :scheme, :type => :string do |urls,scheme|
            urls.all(:scheme => scheme)
          end

          query_option :hosts, :type => :array, :aliases => '-H' do |urls,hosts|
            urls.all('host_name.address' => hosts)
          end

          query_option :ports, :type => :array, :aliases => '-P' do |urls,port|
            urls.all('ports.number' => port)
          end

          query_option :path, :type => :string, :aliases => '-p' do |urls,path|
            urls.all(:path.like => "#{path}%")
          end

          query_option :fragment, :type => :string, :aliases => '-f' do |urls,fragment|
            urls.all(:fragment => fragment)
          end

          query_option :query_params, :type => :array, :aliases => '-q' do |urls,query_params|
            urls.all('query_params.name' => query_params)
          end

          query_option :query_values, :type => :array do |urls,query_values|
            urls.all('query_params.value' => query_values)
          end

          class_option :list, :type => :boolean,
                              :default => true,
                              :aliases => '-l'

          class_option :import, :type => :string,
                                :aliases => '-i',
                                :banner => 'FILE'

          #
          # Queries the {Ronin::URL} model.
          #
          # @since 1.0.0
          #
          def execute
            if options[:import]
              import options[:import]
            elsif options.list?
              super
            end
          end

          protected

          #
          # Imports URLs from a file.
          #
          # @param [String] path
          #   The path to the file.
          #
          # @since 1.0.0
          #
          def import(path)
            File.open(path) do |file|
              file.each_line do |line|
                line.strip!
                next if line.empty?

                url = URL.parse(line)

                if url.save
                  print_info "Imported #{url}"
                else
                  print_error "Could not import #{line.dump}."
                end
              end
            end
          end

          #
          # Prints a URL.
          #
          # @param [Ronin::URL] url
          #   The URL to print.
          #
          # @since 1.0.0
          #
          def print_resource(url)
            return super(url) unless options.verbose?

            print_title url

            indent do
              print_hash(
                'Host' => url.host_name,
                'Port' => url.port.number,
                'Path' => url.path,
                'Fragment' => url.fragment,
                'Last Scanned' => url.last_scanned_at
              )

              unless url.query_params.empty?
                params = {}

                url.query_params.each do |param|
                  params[param.name] = param.value
                end

                print_hash params, :title => 'Query Params'
              end
            end
          end

        end
      end
    end
  end
end
