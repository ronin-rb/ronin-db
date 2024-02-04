require 'spec_helper'
require 'ronin/db/cli/commands/services'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::Services do
  include_examples "man_page"
  include_examples "ModelCommand"
end
