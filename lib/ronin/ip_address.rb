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

require 'ronin/address'
require 'ronin/ip_address_mac_address'
require 'ronin/host_name_ip_address'
require 'ronin/model'

require 'ipaddr'

module Ronin
  class IPAddress < Address

    # Type of the address
    property :version, Integer, :set => [4, 6],
                                :required => true

    # The IP Address
    property :address, Types::IPAddress, :required => true,
                                         :unique => true

    # The MAC Addresses associations
    has 0..n, :ip_address_mac_addresses, :model => 'IPAddressMACAddress'

    # The MAC Addresses associated with the IP Address
    has 0..n, :mac_addresses, :through => :ip_address_mac_addresses,
                              :model => 'MACAddress'

    # The host names that the IP Address serves
    has 0..n, :host_name_ip_addresses, :model => 'HostNameIPAddress'

    # The host names associated with the IP Address
    has 0..n, :host_names, :through => :host_name_ip_addresses

    # Ports of the host
    has 0..n, :open_ports

    #
    # The MAC Address that was most recently used by the IP Address.
    #
    # @return [MacAddress]
    #   The MAC Address that most recently used the IP Address.
    #
    # @since 0.4.0
    #
    def recent_mac_address
      relation = self.ip_address_mac_addresses.first(:order => [:created_at.desc])

      if relation
        return relation.mac_address
      end
    end

    #
    # The host name that was most recently used by the IP Address.
    #
    # @return [HostName]
    #   The host name that most recently used by the IP Address.
    #
    # @since 0.4.0
    #
    def recent_host_name
      relation = self.host_name_ip_addresses.first(:order => [:created_at.desc])

      if relation
        return relation.host_name
      end
    end

    #
    # Converts the address to an IP address object.
    #
    # @return [IPAddr]
    #   The IPAddr object representing either the IPv4 or IPv6 address.
    #
    # @since 0.4.0
    #
    def to_ip
      self.address
    end

    #
    # Converts the address to an Integer.
    #
    # @return [Integer]
    #   The network representation of the IP address.
    #
    # @since 0.4.0
    #
    def to_i
      self.address.to_i
    end

    #
    # Converts the address to a string.
    #
    # @return [String]
    #   The address.
    #
    # @since 0.4.0
    #
    def to_s
      self.address.to_s
    end

  end
end
