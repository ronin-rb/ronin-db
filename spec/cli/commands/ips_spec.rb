require 'spec_helper'
require 'ronin/db/cli/commands/ips'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Ips do
  include_examples "man_page"
end
