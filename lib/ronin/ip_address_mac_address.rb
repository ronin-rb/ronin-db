#
# Copyright (c) 2006-2021 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin.
#
# Ronin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ronin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ronin.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/model'

require 'dm-timestamps'

module Ronin
  #
  # Associates an {IPAddress} with a {MACAddress}.
  #
  class IPAddressMACAddress

    include Model

    # The primary-key of the join model.
    property :id, Serial

    # The IP Address
    belongs_to :ip_address, model: 'IPAddress'

    # The Mac Address
    belongs_to :mac_address, model: 'MACAddress'

    # Tracks when an IP Address becomes associated with a MAC Address
    timestamps :created_at

  end
end
