#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-db.
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

require 'ronin/db/model'

require 'dm-timestamps'

module Ronin
  module DB
    #
    # Represents a guess about what {OS} an {IPAddress} might be running.
    #
    class OSGuess

      include Model

      # The primary-key of the OS guess.
      property :id, Serial

      # The IP Address the OS guess was made against.
      belongs_to :ip_address, model: 'IPAddress'

      # The guessed OS.
      belongs_to :os, model: 'OS'

      # Tracks when an OS guess is made against an IP Address.
      timestamps :created_at

    end
  end
end
