require 'spec_helper'
require 'ronin/db'
require 'ronin/db/models'

describe Ronin::DB do
  describe ".logger=" do
    before do
      @original_logger = ActiveRecord::Base.logger
    end

    let(:new_logger) { Logger.new(STDOUT) }

    it "must set the ActiveRecord::Base.logger" do
      subject.logger = new_logger

      expect(ActiveRecord::Base.logger).to be(new_logger)
    end

    after do
      ActiveRecord::Base.logger = @original_logger
    end
  end

  describe ".config" do
    let(:config) do
      {
        test: {
          adapter: 'sqlite3',
          database: '/path/to/database.sqlite3'
        }
      }
    end

    before do
      subject.instance_variable_set('@config',nil)
    end

    it "must call ConfigFile.load" do
      expect(described_class::ConfigFile).to receive(:load).and_return(config)

      expect(subject.config).to eq(config)
    end

    it "must memoize the result of ConfigFile.load" do
      expect(described_class::ConfigFile).to receive(:load).and_return(config).once

      expect(subject.config).to eq(config)
      expect(subject.config).to be(subject.config)
    end

    after do
      subject.instance_variable_set('@config',nil)
    end
  end

  describe ".migrate!" do
    it "must call Migrations.migrate" do
      expect(described_class::Migrations).to receive(:migrate)

      subject.migrate!
    end
  end

  describe ".migrate" do
    context "when the current migration version is 0" do
      before do
        expect(described_class::Migrations).to receive(:current_version).and_return(0)
      end

      it "must call Migrations.migrate" do
        expect(described_class::Migrations).to receive(:migrate)

        subject.migrate
      end
    end

    context "when there are pending Migrations" do
      before do
        expect(described_class::Migrations).to receive(:current_version).and_return(1)
        expect(described_class::Migrations).to receive(:needs_migration?).and_return(true)
      end

      it "must print a warning" do
        expect(subject).to receive(:warn).with("WARNING: Database requires migrating!")

        subject.migrate
      end
    end
  end

  describe ".connect" do
    context "when given no arguments" do
      let(:config)   { described_class::ConfigFile::DEFAULT_CONFIG }
      let(:database) { :default }

      it "must pass the default database configuration to ActiveRecord::Base.establish_connection, call .migrate, and Models.connect" do
        expect(ActiveRecord::Base).to receive(:establish_connection).with(config[database])
        expect(subject).to receive(:migrate)
        expect(described_class::Models).to receive(:connect)

        subject.connect
      end

      context "and when given migrate: true" do
        it "must pass the default database configuration to ActiveRecord::Base.establish_connection, call .migrate!, and Models.connect" do
          expect(ActiveRecord::Base).to receive(:establish_connection).with(config[database])
          expect(subject).to receive(:migrate!)
          expect(described_class::Models).to receive(:connect)

          subject.connect(migrate: true)
        end
      end

      context "and when given load_models: false" do
        it "must pass the default database configuration to ActiveRecord::Base.establish_connection and call .migrate" do
          expect(ActiveRecord::Base).to receive(:establish_connection).with(config[database])
          expect(subject).to receive(:migrate)
          expect(described_class::Models).to_not receive(:connect)

          subject.connect(load_models: false)
        end
      end
    end

    context "when given a Symbol argument" do
      context "and it's a known database in .config" do
        let(:config) do
          {
            test: {
              adapter: 'sqlite3',
              database: '/path/to/database.sqlite3'
            }
          }
        end
        let(:database) { :test }

        before do
          expect(subject).to receive(:config).and_return(config)
        end

        it "must pass the database's config Hash to ActiveRecord::Base.establish_connection, call .migrate, and Models.connect" do
          expect(ActiveRecord::Base).to receive(:establish_connection).with(config[database])
          expect(subject).to receive(:migrate)
          expect(described_class::Models).to receive(:connect)

          subject.connect(database)
        end
      end

      context "when it's not a known database name in .config" do
        let(:database) { :foo }

        it do
          expect {
            subject.connect(database)
          }.to raise_error(described_class::UnknownDatabase,"unknown database: #{database.inspect}")
        end
      end

      context "when it's another kind of Object" do
        let(:database) { Object.new }

        it do
          expect {
            subject.connect(database)
          }.to raise_error(ArgumentError,"#{described_class}.connect only accepts a Symbol or a Hash")
        end
      end
    end

    context "when given a Hash argument" do
      let(:database) do
        {
          adapter: 'sqlite3',
          database: '/path/to/database.sqlite3'
        }
      end

      it "must call ActiveRecord::Base.establish_connect with the Hash argument, call .migrate, and Models.connect" do
        expect(ActiveRecord::Base).to receive(:establish_connection).with(database)
        expect(subject).to receive(:migrate)
        expect(described_class::Models).to receive(:connect)

        subject.connect(database)
      end
    end
  end
end
