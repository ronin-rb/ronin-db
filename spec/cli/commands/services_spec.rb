require 'spec_helper'
require 'ronin/db/cli/commands/services'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Services do
  include_examples "man_page"
end
