require 'spec_helper'
require 'ronin/db/cli/commands/creds'
require_relative 'man_page_example'
require_relative 'model_command_examples'

require 'ronin/db/credential'

describe Ronin::DB::CLI::Commands::Creds do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.option_parser.parse(argv) }

    describe "--for-user USER" do
      let(:user) { 'bob' }
      let(:argv) { ['--for-user', user] }

      it "must append :for_user and the user to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_user, [user]]
        )
      end

      it "and .for_user must be a class method on Ronin::DB::Credential" do
        expect(Ronin::DB::Credential).to respond_to(:for_user)
      end
    end

    describe "--with-password PASSWORD" do
      let(:password) { 's3cr3t' }
      let(:argv)     { ['--with-password', password] }

      it "must append :with_password and the password to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_password, [password]]
        )
      end

      it "and .with_password must be a class method on Ronin::DB::Credential" do
        expect(Ronin::DB::Credential).to respond_to(:with_password)
      end
    end
  end
end
