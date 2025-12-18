require 'spec_helper'
require 'ronin/db/cli/commands/open_ports'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::OpenPorts do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.option_parser.parse(argv) }

    describe "--with-port PORT" do
      let(:port) { 5432 }
      let(:argv) { ['--with-port', port.to_s] }

      it "must append :with_port_number and the PORT to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_port_number, [port]]
        )
      end

      it "and .with_port_number must be a class method on Ronin::DB::OpenPort" do
        expect(Ronin::DB::OpenPort).to respond_to(:with_port_number)
      end
    end

    describe "--with-protocol tcp|udp" do
      let(:protocol) { :tcp }
      let(:argv) { ['--with-protocol', protocol] }

      it "must append :with_protocol and the protocol to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_protocol, [protocol]]
        )
      end

      it "and .with_protocol must be a class method on Ronin::DB::OpenPort" do
        expect(Ronin::DB::OpenPort).to respond_to(:with_protocol)
      end
    end

    describe "--with-service SERVICE" do
      let(:service) { 'https' }
      let(:argv) { ['--with-service', service] }

      it "must append :with_service and the SERVICE to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_service_name, [service]]
        )
      end

      it "and .with_service_name must be a class method on Ronin::DB::OpenPort" do
        expect(Ronin::DB::OpenPort).to respond_to(:with_service_name)
      end
    end

    describe "--with-ip IP" do
      let(:ip) { '1.2.3.4' }
      let(:argv) { ['--with-ip', ip] }

      it "must append :with_ip_address and the IP to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_ip_address, [ip]]
        )
      end

      it "and .with_ip_address must be a class method on Ronin::DB::OpenPort" do
        expect(Ronin::DB::OpenPort).to respond_to(:with_ip_address)
      end
    end
  end
end
