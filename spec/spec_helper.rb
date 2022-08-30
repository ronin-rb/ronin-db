require 'rspec'
require 'simplecov'
SimpleCov.start

require 'active_record'
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', database: ':memory:'
)

RSpec.configure do |specs|
  specs.before(:suite) do
    require 'ronin/db/migrations'
    Ronin::DB::Migrations.migrate
  end
end
