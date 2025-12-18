require 'spec_helper'
require 'ronin/db/cli/commands/passwords'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::Passwords do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.parse_options(argv) }

    describe "--for-user USER" do
      let(:user) { 'admin' }
      let(:argv) { ['--for-user', user] }

      it "must append :for_user and the USER to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_user, [user]]
        )
      end

      it "and .for_user must be a class method on Ronin::DB::Password" do
        expect(Ronin::DB::Password).to respond_to(:for_user)
      end
    end

    describe "--with-email EMAIL" do
      let(:email) { 'admin@example.com' }
      let(:argv) { ['--with-email', email] }

      it "must append :with_email_address and the EMAIL to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_email_address, [email]]
        )
      end

      it "and .with_email_address must be a class method on Ronin::DB::Password" do
        expect(Ronin::DB::Password).to respond_to(:with_email_address)
      end
    end
  end
end
