require 'spec_helper'
require 'ronin/db/cli/ruby_shell'

describe Ronin::DB::CLI::RubyShell do
  describe "#initialize" do
    it "must default #name to 'ronin-db'" do
      expect(subject.name).to eq('ronin-db')
    end

    it "must default #context to Ronin::DB" do
      expect(subject.context).to be(Ronin::DB)
    end
  end
end
