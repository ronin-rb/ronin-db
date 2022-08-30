require 'spec_helper'
require 'ronin/db/cli/commands/console'

describe Ronin::DB::CLI::Commands::Console do
  describe "#run" do
    it "must call #connet, then #load_models, then CLI::Console.start" do
      expect(subject).to receive(:connect)
      expect(subject).to receive(:load_models)
      expect(Ronin::DB::CLI::Console).to receive(:start)

      subject.run
    end

    context "when #options[:no_connect] is set" do
      before { subject.options[:no_connect] = true }

      it "must not call #connet or #load_models" do
        expect(subject).to_not receive(:connect)
        expect(subject).to_not receive(:load_models)
        expect(Ronin::DB::CLI::Console).to receive(:start)

        subject.run
      end
    end
  end
end
