require 'spec_helper'
require 'ronin/db/cli/commands/software'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Software do
  include_examples "man_page"
end
