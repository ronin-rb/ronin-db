require 'spec_helper'
require 'ronin/db/cli/commands/list'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::List do
  include_examples "man_page"

  describe "#run" do
  end
end
