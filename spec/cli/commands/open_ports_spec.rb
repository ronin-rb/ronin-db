require 'spec_helper'
require 'ronin/db/cli/commands/open_ports'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::OpenPorts do
  include_examples "man_page"
end
