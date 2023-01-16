require 'spec_helper'
require 'ronin/db/cli/commands/remove'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Remove do
  include_examples "man_page"
end
