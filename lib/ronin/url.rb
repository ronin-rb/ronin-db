#
# Ronin - A Ruby platform for exploit development and security research.
#
# Copyright (c) 2009-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/url_scheme'
require 'ronin/url_query_param'
require 'ronin/host_name'
require 'ronin/tcp_port'
require 'ronin/web_credential'
require 'ronin/comment'
require 'ronin/model'

require 'dm-timestamps'
require 'dm-tags'
require 'uri'
require 'uri/query_params'

module Ronin
  class URL

    include Model
    include DataMapper::Timestamps

    # Mapping of URL Schemes and URI classes
    SCHEMES = {
      'https' => ::URI::HTTPS,
      'http' => ::URI::HTTP,
      'ftp' => ::URI::FTP
    }

    # Primary key of the URL
    property :id, Serial

    # The scheme of the URL
    belongs_to :scheme, :model => 'URLScheme'

    # The host name of the URL
    belongs_to :host_name

    # Port of the URL
    belongs_to :port, :model => 'TCPPort'

    # Path of the URL
    property :path, String, :default => ''

    # The fragment of the URL
    property :fragment, String

    # The query params of the URL
    has 0..n, :query_params, :model => 'URLQueryParam'

    # Any credentials used with the URL
    has 0..n, :web_credentials

    # Comments on the URL
    has 0..n, :comments

    # Defines the created_at timestamp
    timestamps :created_at

    # Tags
    has_tags_on :tags

    #
    # Parses the URL.
    #
    # @param [String] url
    #   The raw URL to parse.
    #
    # @return [URL]
    #   The parsed URL.
    #
    # @since 0.4.0
    #
    def URL.parse(url)
      uri = ::URI.parse(url)
      new_url = URL.new(
        :scheme => URLScheme.first_or_new(:name => uri.scheme),
        :host_name => HostName.first_or_new(:address => uri.host),
        :port => TCPPort.first_or_new(:number => uri.port),
        :path => uri.path,
        :fragment => uri.fragment
      )

      if uri.respond_to?(:query_params)
        uri.query_params.each do |name,value|
          new_url.query_params.new(:name => name, :value => value)
        end
      end

      return new_url
    end

    #
    # The host name of the url.
    #
    # @return [String]
    #   The address of host name.
    #
    # @since 0.4.0
    #
    def host
      self.host_name.address
    end

    #
    # The port number used by the URL.
    #
    # @return [Integer]
    #   The port number.
    #
    # @since 0.4.0
    #
    def port_number
      self.port.number
    end

    #
    # Dumps the URL query params into a URI query string.
    #
    # @return [String]
    #   The URI query string.
    #
    # @since 0.4.0
    #
    def query_string
      params = {}

      self.query_params.each do |param|
        params[param.name] = param.value
      end

      return URI::QueryParams.dump(params)
    end

    #
    # Sets the query params of the URL.
    #
    # @param [String] query
    #   The query string to parse.
    #
    # @return [String]
    #   The given query string.
    #
    # @since 0.4.0
    #
    def query_string=(query)
      self.query_params.clear

      URI::QueryParams.parse(query).each do |name,value|
        self.query_params.new(:name => name, :value => value)
      end

      return query
    end

    #
    # Builds a URI object from the url.
    #
    # @return [URI::HTTP, URI::HTTPS]
    #   The URI object created from the url attributes.
    #
    # @since 0.4.0
    #
    def to_uri
      url_class = (SCHEMES[self.scheme.name] || ::URI::Generic)

      host = if self.host_name
               self.host_name.address
             end
      port = if self.port
               self.port.number
             end

      return url_class.build(
        :scheme => self.scheme.name,
        :host => host,
        :port => port,
        :path => self.path,
        :query => self.query_string,
        :fragment => self.fragment
      )
    end

    #
    # Converts the url to a String.
    #
    # @return [String]
    #   The string form of the url.
    #
    # @since 0.4.0
    #
    def to_s
      self.to_uri.to_s
    end

  end
end
