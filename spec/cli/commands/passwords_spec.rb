require 'spec_helper'
require 'ronin/db/cli/commands/passwords'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Passwords do
  include_examples "man_page"
end
