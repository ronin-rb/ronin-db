require 'spec_helper'
require 'ronin/db/cli/commands/emails'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Emails do
  include_examples "man_page"
end
