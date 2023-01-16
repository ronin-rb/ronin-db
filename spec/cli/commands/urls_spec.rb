require 'spec_helper'
require 'ronin/db/cli/commands/urls'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Urls do
  include_examples "man_page"
end
