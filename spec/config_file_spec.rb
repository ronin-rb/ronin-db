require 'spec_helper'
require 'ronin/db/config_file'

require 'tempfile'
require 'tmpdir'

describe Ronin::DB::ConfigFile do
  describe ".validate" do
    context "when the config data is not a Hash" do
      let(:path)   { '/path/to/database.yml' }
      let(:config) { [] }

      it do
        expect {
          subject.validate(path,config)
        }.to raise_error(Ronin::DB::InvalidConfig,"config data must be a Hash: #{config.inspect}")
      end
    end

    context "when the config data Hash contains a non-String/non-Symbol key" do
      let(:path)   { '/path/to/database.yml' }
      let(:key)    { 1 }
      let(:config) do
        {
          :foo  => {},
          key   => {}
        }
      end

      it do
        expect {
          subject.validate(path,config)
        }.to raise_error(Ronin::DB::InvalidConfig,"all Hash keys must be a Symbol: #{key.inspect}")
      end
    end

    context "when the config data Hash contains a non-Hash value" do
      let(:path)   { '/path/to/database.yml' }
      let(:value)  { [] }
      let(:config) do
        {
          foo: {
            adapter: 'sqlite3',
            path:    '/path/to/database.sqlite3'
          },
          bar: value
        }
      end

      it do
        expect {
          subject.validate(path,config)
        }.to raise_error(Ronin::DB::InvalidConfig,"all Hash values must also be a Hash: #{value.inspect}")
      end
    end

    context "when the config data Hash values contains a non-Symbol key" do
      let(:path)    { '/path/to/database.yml' }
      let(:sub_key) { 1 }
      let(:config) do
        {
          foo: {
            adapter: 'sqlite3',
            path:    '/path/to/database.sqlite3'
          },
          bar: {
            adapter:   'sqlite3',
            sub_key => '/path/to/database.sqlite3'
          }
        }
      end

      it do
        expect {
          subject.validate(path,config)
        }.to raise_error(Ronin::DB::InvalidConfig,"all sub-keys must be a Symbol: #{sub_key.inspect}")
      end
    end
  end

  describe ".load" do
    context "when the given path exists" do
      let(:tempfile) { Tempfile.new(['ronin-db-config', '.yml']) }
      let(:path)     { tempfile.path }

      let(:explicit_config) do
        {
          my_database: {
            adapter:  'sqlite3',
            database: '/path/to/database.sqlite3'
          }
        }
      end

      before do
        File.write(path,explicit_config.to_yaml)
      end

      it "must load the YAML data from the path, but merge it with the DEFAULT_CONFIG" do
        config = subject.load(path)

        expect(config).to eq(
          described_class::DEFAULT_CONFIG.merge(explicit_config)
        )
      end
    end

    context "when the given path does not exist" do
      let(:path) { '/does/not/exist' }

      it "must return the DEFAULT_CONFIG" do
        expect(subject.load(path)).to be(described_class::DEFAULT_CONFIG)
      end
    end
  end

  describe ".edit" do
    let(:database_name) { :new_database }
    let(:database_config) do
      {
        adapter:  'sqlite3',
        database: '/path/to/database.sqlite3'
      }
    end

    context "when the given path exists" do
      let(:tempfile) { Tempfile.new(['ronin-db-config', '.yml']) }
      let(:path)     { tempfile.path }

      let(:existing_config) do
        {
          other_database: {
            adapter:  'sqlite3',
            database: '/path/to/other_database.sqlite3'
          }
        }
      end
      let(:additional_config) do
        {
          database_name => database_config
        }
      end

      before do
        File.write(path,existing_config.to_yaml)
      end

      before do
        subject.edit(path) do |config|
          config[database_name] = database_config
        end
      end

      it "must edit the YAML file and save the changes" do
        config = YAML.load_file(path)

        expect(config).to eq(existing_config.merge(additional_config))
      end
    end

    context "when the given path does not exist" do
      let(:root) { Dir.mktmpdir('ronin-db-') }
      let(:path) { File.join(root,'.config','ronin-db','database.yml') }

      before do
        subject.edit(path) do |config|
          config[database_name] = database_config
        end
      end

      it "must create the parent directories before opening the file" do
        expect(File.directory?(File.dirname(path))).to be(true)
      end

      it "must create a new YAML file" do
        config = YAML.load_file(path)

        expect(config[database_name]).to eq(database_config)
      end
    end
  end
end
