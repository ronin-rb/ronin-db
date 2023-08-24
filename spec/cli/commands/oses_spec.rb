require 'spec_helper'
require 'ronin/db/cli/commands/oses'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Oses do
  include_examples "man_page"
end
