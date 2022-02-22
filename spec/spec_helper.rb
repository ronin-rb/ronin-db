require 'rspec'
require 'simplecov'
SimpleCov.start

require 'ronin/db'
include Ronin::DB

Ronin::DB.connect(adapter: 'sqlite3', database: ':memory:')
