require 'spec_helper'
require 'ronin/db/cli/printing'
require 'ronin/db/host_name'
require 'ronin/db/ip_address'
require 'ronin/db/mac_address'
require 'ronin/db/port'
require 'ronin/db/service'
require 'ronin/db/open_port'

describe Ronin::DB::CLI::Printing do
  module TestCLIPrinting
    class TestCommand
      include Ronin::DB::CLI::Printing
    end
  end

  let(:command_class) { TestCLIPrinting::TestCommand }
  subject { command_class.new }

  describe "#record_type" do
    context "when given a Ronin::DB::HostName object" do
      it "must return 'host'" do
        expect(subject.record_type(Ronin::DB::HostName.new)).to eq('host')
      end
    end

    context "when given a Ronin::DB::IPAddress object" do
      it "must return 'IP'" do
        expect(subject.record_type(Ronin::DB::IPAddress.new)).to eq('IP')
      end
    end

    context "when given a Ronin::DB::MACAddress object" do
      it "must return 'MAC'" do
        expect(subject.record_type(Ronin::DB::MACAddress.new)).to eq('MAC')
      end
    end

    context "when given a Ronin::DB::Port object" do
      it "must return 'port'" do
        expect(subject.record_type(Ronin::DB::Port.new)).to eq('port')
      end
    end

    context "when given a Ronin::DB::Service object" do
      it "must return 'service'" do
        expect(subject.record_type(Ronin::DB::Service.new)).to eq('service')
      end
    end

    context "when given a Ronin::DB::OpenPort object" do
      it "must return 'open port'" do
        expect(subject.record_type(Ronin::DB::OpenPort.new)).to eq('open port')
      end
    end
  end
end
