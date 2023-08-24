require 'spec_helper'
require 'ronin/db/cli/commands/certs'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Certs do
  include_examples "man_page"
end
