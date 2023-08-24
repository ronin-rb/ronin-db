require 'spec_helper'
require 'ronin/db/cli/commands/ports'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Ports do
  include_examples "man_page"
end
