require 'spec_helper'
require 'ronin/db/cli/commands/creds'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Creds do
  include_examples "man_page"
end
