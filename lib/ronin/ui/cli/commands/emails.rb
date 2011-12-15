#
# Copyright (c) 2006-2011 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of Ronin.
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
# along with Ronin.  If not, see <http://www.gnu.org/licenses/>.
#

require 'ronin/ui/cli/resources_command'
require 'ronin/email_address'

module Ronin
  module UI
    module CLI
      module Commands
        #
        # The `ronin-emails` command.
        #
        class Emails < ResourcesCommand

          model EmailAddress

          query_option :with_hosts, :type  => Array,
                                    :flag  => '-H',
                                    :usage => 'HOST [...]'

          query_option :with_ips, :type  => Array,
                                  :flag  => '-I',
                                  :usage => 'IP [...]'

          query_option :with_users, :type  => Array,
                                    :flag  => '-u',
                                    :usage => 'NAME [...]'

          option :list, :type    => true,
                        :default => true,
                        :flag    => '-l'

          option :import, :type  => String,
                          :flag  => '-i',
                          :usage => 'FILE'

        end
      end
    end
  end
end
