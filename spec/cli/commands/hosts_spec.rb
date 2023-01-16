require 'spec_helper'
require 'ronin/db/cli/commands/hosts'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Hosts do
  include_examples "man_page"
end
