require 'spec_helper'
require 'ronin/db/cli/commands/software'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::Software do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.parse_options(argv) }

    describe "--name NAME" do
      let(:name) { 'Apache' }
      let(:argv) { ['--name', name] }

      it "must append :with_name and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_name, [name]]
        )
      end

      it "and .with_name must be a class method on Ronin::DB::Software" do
        expect(Ronin::DB::Software).to respond_to(:with_name)
      end
    end

    describe "--named NAME" do
      let(:name) { 'Apache' }
      let(:argv) { ['--named', name] }

      it "must append :named and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:named, [name]]
        )
      end

      it "and .named must be a class method on Ronin::DB::Software" do
        expect(Ronin::DB::Software).to respond_to(:named)
      end
    end

    describe "--version VERSION" do
      let(:version) { '2.4.41' }
      let(:argv) { ['--version', version] }

      it "must append :with_version and the VERSION to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_version, [version]]
        )
      end

      it "and .with_version must be a class method on Ronin::DB::Software" do
        expect(Ronin::DB::Software).to respond_to(:with_version)
      end
    end

    describe "--vendor VENDOR" do
      let(:vendor) { 'Apache Software Foundation' }
      let(:argv) { ['--vendor', vendor] }

      it "must append :with_vendor_name and the VENDOR to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_vendor_name, [vendor]]
        )
      end

      it "and .with_vendor_name must be a class method on Ronin::DB::Software" do
        expect(Ronin::DB::Software).to respond_to(:with_vendor_name)
      end
    end
  end
end
