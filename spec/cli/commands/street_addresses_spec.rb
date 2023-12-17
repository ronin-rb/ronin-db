require 'spec_helper'
require 'ronin/db/cli/commands/street_addresses'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::StreetAddresses do
  include_examples "man_page"
end
