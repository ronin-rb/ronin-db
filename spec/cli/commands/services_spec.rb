require 'spec_helper'
require 'ronin/db/cli/commands/services'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::Services do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.parse_options(argv) }

    describe "--named NAME" do
      let(:name) { 'http' }
      let(:argv) { ['--named', name] }

      it "must append :named and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:named, [name]]
        )
      end

      it "and .named must be a class method on Ronin::DB::Service" do
        expect(Ronin::DB::Service).to respond_to(:named)
      end
    end

    describe "--with-port PORT" do
      let(:port) { 80 }
      let(:argv) { ['--with-port', port.to_s] }

      it "must append :with_port_number and the PORT to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_port_number, [port]]
        )
      end

      it "and .with_port_number must be a class method on Ronin::DB::Service" do
        expect(Ronin::DB::Service).to respond_to(:with_port_number)
      end
    end

    describe "--with-protocol PROTOCOL" do
      let(:protocol) { :tcp }
      let(:argv) { ['--with-protocol', protocol.to_s] }

      it "must append :with_protocol and the PROTOCOL to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_protocol, [protocol]]
        )
      end

      it "and .with_protocol must be a class method on Ronin::DB::Service" do
        expect(Ronin::DB::Service).to respond_to(:with_protocol)
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

      it "and .with_ip_address must be a class method on Ronin::DB::Service" do
        expect(Ronin::DB::Service).to respond_to(:with_ip_address)
      end
    end
  end
end
