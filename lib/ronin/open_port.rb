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

require 'ronin/service_credential'
require 'ronin/comment'
require 'ronin/port'
require 'ronin/service'
require 'ronin/ip_address'
require 'ronin/model'

require 'dm-timestamps'
require 'dm-tags'

module Ronin
  class OpenPort

    include Model
    include DataMapper::Timestamps

    # Primary key of the open port
    property :id, Serial

    # any credentials used by the service running on the port
    has 0..n, :service_credentials

    # The comments associated with the open port
    has 0..n, :comments

    # The port
    belongs_to :port

    # The service detected on the port
    belongs_to :service, :required => false

    # The IP Address that was scanned
    belongs_to :ip_address, :model => 'IPAddress'

    # Define the created_at timestamp
    timestamps :created_at

    # Tags
    has_tags_on :tags

    #
    # Converts the open port to an integer.
    #
    # @return [Integer]
    #   The port number.
    #
    # @since 0.4.0
    #
    def to_i
      self.port.to_i
    end

    #
    # Converts the open port to a string.
    #
    # @return [String]
    #   The information of the open port.
    #
    # @since 0.4.0
    #
    def to_s
      str = self.port.to_s
      str = "#{str} (#{self.service})" if self.service

      return str
    end

  end
end
