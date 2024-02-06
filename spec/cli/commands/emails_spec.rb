require 'spec_helper'
require 'ronin/db/cli/commands/emails'
require_relative 'man_page_example'
require_relative 'model_command_examples'

require 'ronin/db/email_address'

describe Ronin::DB::CLI::Commands::Emails do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.option_parser.parse(argv) }

    describe "--with-host HOST" do
      let(:host) { 'example.com' }
      let(:argv) { ['--with-host', host] }

      it "must append :with_host_name and the host to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_host_name, [host]]
        )
      end

      it "and .with_host_name must be a class method on Ronin::DB::EmailAddress" do
        expect(Ronin::DB::EmailAddress).to respond_to(:with_host_name)
      end
    end

    describe "--with-ip IP" do
      let(:ip)   { '1.2.3.4' }
      let(:argv) { ['--with-ip', ip] }

      it "must append :with_ip_address and the IP to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_ip_address, [ip]]
        )
      end

      it "and .with_ip_address must be a class method on Ronin::DB::EmailAddress" do
        expect(Ronin::DB::EmailAddress).to respond_to(:with_ip_address)
      end
    end

    describe "--with-user USER" do
      let(:user) { 'bob' }
      let(:argv) { ['--with-user', user] }

      it "must append :with_user_name and the user to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_user_name, [user]]
        )
      end

      it "and .with_user_name must be a class method on Ronin::DB::EmailAddress" do
        expect(Ronin::DB::EmailAddress).to respond_to(:with_user_name)
      end
    end

    describe "--for-person FULL_NAME" do
      let(:full_name) { 'John Smith' }
      let(:argv)      { ['--for-person', full_name] }

      it "must append :for_person and the full name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_person, [full_name]]
        )
      end

      it "and .for_person must be a class method on Ronin::DB::EmailAddress" do
        expect(Ronin::DB::EmailAddress).to respond_to(:for_person)
      end
    end

    describe "--for-person FULL_NAME" do
      let(:name) { 'ACME, Inc.' }
      let(:argv) { ['--for-organization', name] }

      it "must append :for_organization and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_organization, [name]]
        )
      end

      it "and .for_organization must be a class method on Ronin::DB::EmailAddress" do
        expect(Ronin::DB::EmailAddress).to respond_to(:for_organization)
      end
    end
  end
end
