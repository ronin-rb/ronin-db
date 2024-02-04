require 'spec_helper'
require 'ronin/db/cli/commands/asn'
require_relative 'man_page_example'
require_relative 'model_command_examples'

require 'ronin/db/asn'

describe Ronin::DB::CLI::Commands::Asn do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.option_parser.parse(argv) }

    describe "--number NUM" do
      let(:number) { 1234 }
      let(:argv)   { ['--number', number.to_s] }

      it "must append :with_number and the number to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_number, [number]]
        )
      end

      it "and .with_number must be a class method on Ronin::DB::ASN" do
        expect(Ronin::DB::ASN).to respond_to(:with_number)
      end
    end

    describe "--country-code XX" do
      let(:country_code) { 'US' }
      let(:argv)         { ['--country-code', country_code] }

      it "must append :with_country_code and the country code to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_country_code, [country_code]]
        )
      end

      it "and .with_country_code must be a class method on Ronin::DB::ASN" do
        expect(Ronin::DB::ASN).to respond_to(:with_country_code)
      end
    end

    describe "--name NAME" do
      let(:name) { 'FOO BAR ISP' }
      let(:argv) { ['--name', name] }

      it "must append :with_name and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_name, [name]]
        )
      end

      it "and .with_name must be a class method on Ronin::DB::ASN" do
        expect(Ronin::DB::ASN).to respond_to(:with_name)
      end
    end

    describe "--named NAME" do
      let(:name) { 'FOO' }
      let(:argv) { ['--named', name] }

      it "must append :named and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:named, [name]]
        )
      end

      it "and .named must be a class method on Ronin::DB::ASN" do
        expect(Ronin::DB::ASN).to respond_to(:named)
      end
    end

    describe "--ip IP" do
      let(:ip)   { '1.2.3.4' }
      let(:argv) { ['--ip', ip] }

      it "must append :containing_ip and the IP to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:containing_ip, [ip]]
        )
      end

      it "and .containing_ip must be a class method on Ronin::DB::ASN" do
        expect(Ronin::DB::ASN).to respond_to(:containing_ip)
      end
    end

    describe "--ipv4" do
      let(:argv) { ['--ipv4'] }

      it "must append :v4 to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:v4]
        )
      end

      it "and .v4 must be a class method on Ronin::DB::ASN" do
        expect(Ronin::DB::ASN).to respond_to(:v4)
      end
    end

    describe "--ipv6" do
      let(:argv) { ['--ipv6'] }

      it "must append :v6 to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:v6]
        )
      end

      it "and .v6 must be a class method on Ronin::DB::ASN" do
        expect(Ronin::DB::ASN).to respond_to(:v6)
      end
    end
  end
end
