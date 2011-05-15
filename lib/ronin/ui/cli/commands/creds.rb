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

require 'ronin/ui/cli/model_command'
require 'ronin/credential'
require 'ronin/service_credential'
require 'ronin/web_credential'

module Ronin
  module UI
    module CLI
      module Commands
        #
        # The `ronin-creds` command.
        #
        class Creds < ModelCommand

          model Credential

          query_option :for_user, :type => :string,
                                  :aliases => '-u',
                                  :banner => 'USER'

          query_option :with_password, :type => :string,
                                       :aliases => '-p',
                                       :banner => 'PASS'

          class_option :list, :type => :boolean,
                              :default => true,
                              :aliases => '-l'

          #
          # Queries the {Credential} model.
          #
          # @since 1.0.0
          #
          def execute
            if options.list?
              super
            end
          end

          protected

          #
          # Prints a credential.
          #
          # @param [Credential] cred
          #   The credential to display.
          #
          # @since 1.0.0
          #
          def print_resource(cred)
            case cred
            when ServiceCredential
              puts "#{cred}\t(#{cred.open_port.ip_address} #{cred.open_port})"
            when WebCredential
              puts "#{cred}\t(#{cred.url})"
            else
              super(cred)
            end
          end

        end
      end
    end
  end
end
