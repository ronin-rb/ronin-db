require 'spec_helper'
require 'ronin/db/cli/uri_methods'

describe Ronin::DB::CLI::URIMethods do
  subject do
    obj = Object.new
    obj.extend described_class
    obj
  end

  describe "#normalize_adapter" do
    context "when given 'sqlite'" do
      it "must return 'sqlite3'" do
        expect(subject.normalize_adapter('sqlite')).to eq('sqlite3')
      end
    end

    context "when given 'sqlite3'" do
      it "must return 'sqlite3'" do
        expect(subject.normalize_adapter('sqlite3')).to eq('sqlite3')
      end
    end

    context "when given 'mysql'" do
      it "must return 'mysql2'" do
        expect(subject.normalize_adapter('mysql')).to eq('mysql2')
      end
    end

    context "when given 'mysql2'" do
      it "must return 'mysql2'" do
        expect(subject.normalize_adapter('mysql2')).to eq('mysql2')
      end
    end

    context "when given 'postgresql'" do
      it "must return 'postgresql'" do
        expect(subject.normalize_adapter('postgresql')).to eq('postgresql')
      end
    end

    context "when given 'postgres'" do
      it "must return 'postgresql'" do
        expect(subject.normalize_adapter('postgres')).to eq('postgresql')
      end
    end

    context "when given 'psql'" do
      it "must return 'postgresql'" do
        expect(subject.normalize_adapter('psql')).to eq('postgresql')
      end
    end

    context "when given 'pg'" do
      it "must return 'postgresql'" do
        expect(subject.normalize_adapter('pg')).to eq('postgresql')
      end
    end
  end

  describe "#normalize_sqlite3_path" do
    context "when given a relative path" do
      let(:path) { 'file.sqlite3' }

      it "must return an absolute path" do
        expect(subject.normalize_sqlite3_path(path)).to eq(
          File.expand_path(path)
        )
      end
    end

    context "when given an absolute path" do
      let(:path) { '/path/to/file.sqlite3' }

      it "must return the absolute path" do
        expect(subject.normalize_sqlite3_path(path)).to eq(path)
      end
    end

    context "when given ':memory:'" do
      let(:path) { ':memory:' }

      it "must return ':memory:'" do
        expect(subject.normalize_sqlite3_path(path)).to eq(path)
      end
    end
  end

  describe "#parse_uri" do
    [:sqlite3, :sqlite].each do |adapter|
      let(:adapter)  { adapter }

      context "when given '#{adapter}:path'" do
        let(:path) { "db.sqlite3"      }
        let(:uri)  { "#{adapter}:#{path}" }

        it "must return {adapter: 'sqlite3', database: absolute_path}" do
          expect(subject.parse_uri(uri)).to eq(
            {
              adapter: 'sqlite3',
              database: File.expand_path(path)
            }
          )
        end
      end

      context "when given '#{adapter}:/path'" do
        let(:path) { "/db.sqlite3"      }
        let(:uri)  { "#{adapter}:#{path}" }

        it "must return {adapter: 'sqlite3', database: '/path'}" do
          expect(subject.parse_uri(uri)).to eq(
            {
              adapter: 'sqlite3',
              database: path
            }
          )
        end
      end

      context "when given '#{adapter}::memory:'" do
        let(:path) { ":memory:"        }
        let(:uri)  { "#{adapter}:#{path}" }

        it "must return {adapter: 'sqlite3', database: ':memory:'}" do
          expect(subject.parse_uri(uri)).to eq(
            {
              adapter: 'sqlite3',
              database: path
            }
          )
        end
      end
    end

    [:mysql2, :mysql].each do |adapter|
      context "when given '#{adapter}://user:password@host:port/database'" do
        let(:adapter)  { adapter }
        let(:user)     { 'foo' }
        let(:password) { 'secret' }
        let(:host)     { 'example.com' }
        let(:port)     { 1234   }
        let(:database) { 'test' }
        let(:uri) do
          "#{adapter}://#{user}:#{password}@#{host}:#{port}/#{database}"
        end

        it "must return {adapter: 'mysql2', username: '...', password: '...', host: '...', port: ..., database: 'database'}" do
          expect(subject.parse_uri(uri)).to eq(
            {
              adapter: 'mysql2',
              username: user,
              password: password,
              host:     host,
              port:     port,
              database: database
            }
          )
        end
      end
    end

    [:postgresql, :postgres, :psql, :pg].each do |adapter|
      context "when given '#{adapter}://user:password@host:port/database'" do
        let(:adapter)  { adapter }
        let(:user)     { 'foo' }
        let(:password) { 'secret' }
        let(:host)     { 'example.com' }
        let(:port)     { 1234   }
        let(:database) { 'test' }
        let(:uri) do
          "#{adapter}://#{user}:#{password}@#{host}:#{port}/#{database}"
        end

        it "must return {adapter: 'postgresql', username: '...', password: '...', host: '...', port: ..., database: 'database'}" do
          expect(subject.parse_uri(uri)).to eq(
            {
              adapter: 'postgresql',
              username: user,
              password: password,
              host:     host,
              port:     port,
              database: database
            }
          )
        end
      end
    end
  end
end
