require 'spec_helper'
require 'ronin/db/cli/commands/migrate'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Migrate do
  include_examples "man_page"
end
