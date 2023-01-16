require 'spec_helper'
require 'ronin/db/cli/commands/edit'
require_relative 'man_page_example'

describe Ronin::DB::CLI::Commands::Edit do
  include_examples "man_page"

  describe "#run" do
    it "must edit the ConfigFile::PATH" do
      expect(subject).to receive(:edit).with(Ronin::DB::ConfigFile::PATH)

      subject.run
    end
  end
end
