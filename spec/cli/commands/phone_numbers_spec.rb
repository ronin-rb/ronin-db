require 'spec_helper'
require 'ronin/db/cli/commands/phone_numbers'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::PhoneNumbers do
  include_examples "man_page"
end
