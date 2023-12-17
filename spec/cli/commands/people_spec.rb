require 'spec_helper'
require 'ronin/db/cli/commands/people'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::People do
  include_examples "man_page"
end
