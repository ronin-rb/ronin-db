require 'spec_helper'
require 'ronin/db/cli/commands/add'

describe Ronin::DB::CLI::Commands::Add do
  describe "options" do
    before { subject.parse_options(argv) }

    describe "--adapter" do
      let(:adapter) { 'sqlite3' }
      let(:argv)    { ['--adapter', adapter] }

      it "must set #config[:adapter]" do
        expect(subject.config[:adapter]).to eq(adapter)
      end
    end

    describe "--sqlite3" do
      let(:database) { '/path/to/file.sqlite3' }
      let(:argv)     { ['--sqlite3', database] }

      it "must set #config[:adapter] to 'sqlite3'" do
        expect(subject.config[:adapter]).to eq('sqlite3')
      end

      it "must set #config[:database] to the given path" do
        expect(subject.config[:database]).to eq(database)
      end

      context "when the argument is a relative path" do
        let(:database) { 'file.sqlite3' }

        it "must expand the relative path before setting #config[:database]" do
          expect(subject.config[:database]).to eq(File.expand_path(database))
        end
      end
    end

    describe "--mysql2" do
      let(:argv) { ['--mysql2'] }

      it "must set #config[:adapter] to 'mysql2'" do
        expect(subject.config[:adapter]).to eq('mysql2')
      end
    end

    describe "--postgresql" do
      let(:argv) { ['--postgresql'] }

      it "must set #config[:adapter] to 'postgresql'" do
        expect(subject.config[:adapter]).to eq('postgresql')
      end
    end

    describe "--host" do
      let(:host) { 'example.com'    }
      let(:argv) { ['--host', host] }

      it "must set #config[:host]" do
        expect(subject.config[:host]).to eq(host)
      end
    end

    describe "--port" do
      let(:port) { 1234 }
      let(:argv) { ['--port', port.to_s] }

      it "must set #config[:port]" do
        expect(subject.config[:port]).to eq(port)
      end
    end

    describe "--username" do
      let(:username) { 'foo' }
      let(:argv)     { ['--username', username] }

      it "must set #config[:username]" do
        expect(subject.config[:username]).to eq(username)
      end
    end

    describe "--password" do
      let(:password) { 'secret' }
      let(:argv)     { ['--password', password] }

      it "must set #config[:password]" do
        expect(subject.config[:password]).to eq(password)
      end
    end

    describe "--database" do
      let(:database) { 'foo' }
      let(:argv)     { ['--database', database] }

      it "must set #config[:database]" do
        expect(subject.config[:database]).to eq(database)
      end
    end
  end

  describe "#initialize" do
    it "must initialize #config to an empty Hash" do
      expect(subject.config).to eq({})
    end
  end

  describe "#run" do
    let(:adapter)  { 'sqlite3' }
    let(:database) { '/path/to/test.sqlite3' }
    let(:name)     { 'test' }

    let(:config_file_hash) { {} }

    context "when given a URI argument" do
      let(:uri) { "#{adapter}:#{database}" }

      it "must parse the URI, call ConfigFile.edit, and add #config to it with the given NAME argument" do
        expect(Ronin::DB::ConfigFile).to receive(:edit).and_yield(config_file_hash)

        subject.run(name,uri)

        expect(config_file_hash[name]).to eq(
          {
            adapter:  adapter,
            database: database
          }
        )
      end
    end

    context "when given options instead of a URI argument" do
      let(:argv) do
        [
          '--adapter',  adapter,
          '--database', database
        ]
      end

      before { subject.parse_options(argv) }

      it "must call ConfigFile.edit and add #config to it with the given NAME argument" do
        expect(Ronin::DB::ConfigFile).to receive(:edit).and_yield(config_file_hash)

        subject.run(name)

        expect(config_file_hash[name]).to eq(
          {
            adapter:  adapter,
            database: database
          }
        )
      end
    end

    context "when #config[:adapter] is not set" do
      let(:argv) { ['--database', '/path/to/db.sqlite3'] }

      before { subject.parse_options(argv) }

      it "must print an error message and exit with 1" do
        expect {
          subject.run(name)
        }.to output("add: must specify a URI or the --adapter option#{$/}").to_stderr.and(raise_error(SystemExit))
      end
    end

    context "when #config[:database] is not set" do
      let(:argv) { ['--adapter', 'sqlite3'] }

      before { subject.parse_options(argv) }

      it "must print an error message and exit with 1" do
        expect {
          subject.run(name)
        }.to output("add: must specify a URI or the --database option#{$/}").to_stderr.and(raise_error(SystemExit))
      end
    end
  end

  describe "#read_password" do
    let(:password) { 'secret' }

    it "must call #ask_secret with 'Password' and set config[:password]" do
      expect(subject).to receive(:ask_secret).with('Password').and_return(password)

      subject.read_password

      expect(subject.config[:password]).to eq(password)
    end
  end

  describe "#validate_config!" do
    context "when #config[:adapter] is not set" do
      before do
        subject.config[:database] = '/path/to/db.sqlite3'
      end

      it "must print an error message and exit with 1" do
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.validate_config!
        }.to output("add: must specify a URI or the --adapter option#{$/}").to_stderr
      end
    end

    context "when #config[:database] is not set" do
      before do
        subject.config[:adapter] = 'sqlite3'
      end

      it "must print an error message and exit with 1" do
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.validate_config!
        }.to output("add: must specify a URI or the --database option#{$/}").to_stderr
      end
    end
  end
end
