require 'spec_helper'
require 'ronin/db/cli/database_options'
require 'ronin/db/cli/command'

describe Ronin::DB::CLI::DatabaseOptions do
  module TestDatabaseOptions
    class Command < Ronin::DB::CLI::Command
      include Ronin::DB::CLI::DatabaseOptions
    end
  end

  let(:command_class) { TestDatabaseOptions::Command }
  subject { command_class.new }

  describe "#config" do
    context "when neither options[:db] nor options[:db_uri] are set" do
      it "must default to connecting to the :default database" do
        expect(subject.config).to eq(Ronin::DB.config[:default])
      end
    end

    context "when options[:db] is set" do
      let(:db_name) { :test }
      let(:config) do
        {
          db_name => {
            adapter: 'sqlite3',
            database: '/path/to/db.sqlite3'
          }
        }
      end

      before do
        allow(Ronin::DB).to receive(:config).and_return(config)

        subject.options[:db] = db_name
      end

      it "must return the database configuration for options[:db]" do
        expect(subject.config).to eq(Ronin::DB.config[db_name])
      end
    end

    context "when options[:db_uri] is set" do
      let(:db_uri)     { "postgres://user:password@host:1234/database" }
      let(:parsed_uri) { subject.parse_uri(subject.options[:db_uri])   }

      before { subject.options[:db_uri] = db_uri }

      it "must return the parsed URI for options[:db_uri]" do
        expect(subject.config).to eq(parsed_uri)
      end
    end
  end

  describe "#connect" do
    it "must call ActiveRecord::Base.establish_connection with #config" do
      expect(ActiveRecord::Base).to receive(:establish_connection).with(subject.config)

      subject.connect
    end
  end
end
