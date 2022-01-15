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

require 'ronin/database'

require 'rspec'
require 'tempfile'

RSpec.configure do |spec|
  spec.before(:suite) do
    defaults = {
      user:     'ronin_test',
      password: 'ronin_test',
      database: 'ronin_test'
    }
    adapter  = ENV.fetch('ADAPTER','sqlite3')

    uri = case adapter
          when 'sqlite3', 'sqlite'
            {
              adapter:  'sqlite3',
              database: Tempfile.new('ronin_database').path
            }
          else
            defaults.merge(adapter: adapter)
          end

    # setup the database
    Ronin::Database.setup(uri)
  end

  spec.after(:suite) do
    case adapter
    when 'sqlite3', 'sqlite'
      File.unlink(path)
    end
  end
end
