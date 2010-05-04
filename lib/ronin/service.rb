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

require 'ronin/open_port'
require 'ronin/model'

module Ronin
  class Service

    include Model

    # Primary key of the service
    property :id, Serial

    # Name of the service
    property :name, String, :required => true,
                            :unique => true

    # The open ports running the service
    has 1..n, :open_ports

    #
    # Converts the service to a string.
    #
    # @return [String]
    #   The service name.
    #
    # @since 0.4.0
    #
    def to_s
      self.name.to_s
    end

  end
end
