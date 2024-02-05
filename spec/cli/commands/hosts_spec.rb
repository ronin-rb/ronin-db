require 'spec_helper'
require 'ronin/db/cli/commands/hosts'
require_relative 'man_page_example'
require_relative 'model_command_examples'

require 'ronin/db/host_name'

describe Ronin::DB::CLI::Commands::Hosts do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.option_parser.parse(argv) }

    describe "--with-ip IP" do
      let(:ip)   { '1.2.3.4' }
      let(:argv) { ['--with-ip', ip] }

      it "must append :with_ip_address and the IP to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_ip_address, [ip]]
        )
      end

      it "and .with_ip_address must be a class method on Ronin::DB::HostName" do
        expect(Ronin::DB::HostName).to respond_to(:with_ip_address)
      end
    end

    describe "--with-port PORT" do
      let(:port) { 80 }
      let(:argv) { ['--with-port', port.to_s] }

      it "must append :with_port_number and the port to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_port_number, [port]]
        )
      end

      it "and .with_port_number must be a class method on Ronin::DB::HostName" do
        expect(Ronin::DB::HostName).to respond_to(:with_port_number)
      end
    end

    describe "--domain IP" do
      let(:domain)  { 'example.com' }
      let(:argv)    { ['--domain', domain] }

      it "must append :with_domain and the domain to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_domain, [domain]]
        )
      end

      it "and .with_domain must be a class method on Ronin::DB::HostName" do
        expect(Ronin::DB::HostName).to respond_to(:with_domain)
      end
    end

    describe "--tld TLD" do
      let(:tld)  { 'com' }
      let(:argv) { ['--tld', tld] }

      it "must append :with_tld and the TLD to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_tld, [tld]]
        )
      end

      it "and .with_tld must be a class method on Ronin::DB::HostName" do
        expect(Ronin::DB::HostName).to respond_to(:with_tld)
      end
    end
  end
end
