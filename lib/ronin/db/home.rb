# frozen_string_literal: true
#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/core/home'

module Ronin
  module DB
    module Home
      # The path to the `~/.config/ronin-db/` directory.
      CONFIG_DIR = File.join(Core::Home::CONFIG_DIR,'ronin-db')

      # The path to the `~/.cache/ronin-db/` directory.
      CACHE_DIR = File.join(Core::Home::CACHE_DIR,'ronin-db')

      # The path to the `~/.local/share/ronin-db/` directory.
      LOCAL_SHARE_DIR = File.join(Core::Home::LOCAL_SHARE_DIR,'ronin-db')
    end
  end
end
