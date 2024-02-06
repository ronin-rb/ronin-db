require 'spec_helper'
require 'ronin/db/cli/commands/ips'
require_relative 'man_page_example'
require_relative 'model_command_examples'

require 'ronin/db/ip_address'

describe Ronin::DB::CLI::Commands::Ips do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.option_parser.parse(argv) }

    describe "--v4" do
      let(:argv) { ['--v4'] }

      it "must append :v4 to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          :v4
        )
      end

      it "and .v4 must be a class method on Ronin::DB::IPAddress" do
        expect(Ronin::DB::IPAddress).to respond_to(:v4)
      end
    end

    describe "--v6" do
      let(:argv) { ['--v6'] }

      it "must append :v6 to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          :v6
        )
      end

      it "and .v6 must be a class method on Ronin::DB::IPAddress" do
        expect(Ronin::DB::IPAddress).to respond_to(:v6)
      end
    end

    describe "--with-port PORT" do
      let(:port) { 80 }
      let(:argv) { ['--with-port', port.to_s] }

      it "must append :with_port_number and the port number to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_port_number, [port]]
        )
      end

      it "and .with_port_number must be a class method on Ronin::DB::IPAddress" do
        expect(Ronin::DB::IPAddress).to respond_to(:with_port_number)
      end
    end

    describe "--with-mac-addr MAC" do
      let(:mac)  { '11:22:33:44:55:66' }
      let(:argv) { ['--with-mac-addr', mac] }

      it "must append :with_mac_address and the MAC address to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_mac_address, [mac]]
        )
      end

      it "and .with_mac_address must be a class method on Ronin::DB::IPAddress" do
        expect(Ronin::DB::IPAddress).to respond_to(:with_mac_address)
      end
    end

    describe "--with-host HOST" do
      let(:host) { 'www.example.com' }
      let(:argv) { ['--with-host', host] }

      it "must append :with_host_name and the host name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_host_name, [host]]
        )
      end

      it "and .with_host_name must be a class method on Ronin::DB::IPAddress" do
        expect(Ronin::DB::IPAddress).to respond_to(:with_host_name)
      end
    end
  end
end
