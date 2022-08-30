require 'spec_helper'
require 'ronin/db/cli/commands/edit'

describe Ronin::DB::CLI::Commands::Edit do
  describe "#run" do
    it "must edit the ConfigFile::PATH" do
      expect(subject).to receive(:edit).with(Ronin::DB::ConfigFile::PATH)

      subject.run
    end
  end
end
