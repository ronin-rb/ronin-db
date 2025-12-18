require 'spec_helper'
require 'ronin/db/cli/commands/urls'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::Urls do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.parse_options(argv) }

    describe "--http" do
      let(:argv) { ['--http'] }

      it "must append :http to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(:http)
      end

      it "and .http must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:http)
      end
    end

    describe "--https" do
      let(:argv) { ['--https'] }

      it "must append :https to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(:https)
      end

      it "and .https must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:https)
      end
    end

    describe "--host HOST" do
      let(:host) { 'example.com' }
      let(:argv) { ['--host', host] }

      it "must append :with_host_name and the HOST to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_host_name, [host]]
        )
      end

      it "and .with_host_name must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_host_name)
      end
    end

    describe "--port PORT" do
      let(:port) { 8080 }
      let(:argv) { ['--port', port.to_s] }

      it "must append :with_port_number and the PORT to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_port_number, [port]]
        )
      end

      it "and .with_port_number must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_port_number)
      end
    end

    describe "--path PATH" do
      let(:path) { '/admin' }
      let(:argv) { ['--path', path] }

      it "must append :where with path to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:where, [], {path: path}]
        )
      end
    end

    describe "--fragment FRAGMENT" do
      let(:fragment) { 'section1' }
      let(:argv) { ['--fragment', fragment] }

      it "must append :where with fragment to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:where, [], {fragment: fragment}]
        )
      end
    end

    describe "--directory DIR" do
      let(:dir) { '/uploads' }
      let(:argv) { ['--directory', dir] }

      it "must append :with_directory and the DIR to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_directory, [dir]]
        )
      end

      it "and .with_directory must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_directory)
      end
    end

    describe "--with-ext EXT" do
      let(:ext) { 'php' }
      let(:argv) { ['--with-ext', ext] }

      it "must append :with_ext and the EXT to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_ext, [ext]]
        )
      end

      it "and .with_ext must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_file_ext)
      end
    end

    describe "--query-string STRING" do
      let(:string) { 'page=1&sort=name' }
      let(:argv) { ['--query-string', string] }

      it "must append :where with query to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:where, [], {query: string}]
        )
      end
    end

    describe "--with-query-param NAME[=VALUE]" do
      let(:name) { 'page' }
      let(:argv) { ['--with-query-param', name] }

      context "when only NAME is given" do
        it "must append :with_query_param_name and the NAME to #query_method_calls" do
          expect(subject.query_method_calls[-1]).to eq(
            [:with_query_param_name, [name]]
          )
        end
      end

      context "when NAME=VALUE is given" do
        let(:name) { 'page' }
        let(:value) { '1' }
        let(:argv) { ['--with-query-param', "#{name}=#{value}"] }

        it "must append :with_query_param with the NAME and VALUE to #query_method_calls" do
          expect(subject.query_method_calls[-1]).to eq(
            [:with_query_param, [name, value]]
          )
        end
      end

      it "and .with_query_param must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_query_param)
      end

      it "and .with_query_param_name must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_query_param_name)
      end
    end

    describe "--with-query-param-name NAME" do
      let(:name) { 'page' }
      let(:argv) { ['--with-query-param-name', name] }

      it "must append :with_query_param_name and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_query_param_name, [name]]
        )
      end

      it "and .with_query_param_name must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_query_param_name)
      end
    end

    describe "--with-query-param-value VALUE" do
      let(:value) { '1' }
      let(:argv) { ['--with-query-param-value', value] }

      it "must append :with_query_param_value and the VALUE to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_query_param_value, [value]]
        )
      end

      it "and .with_query_param_value must be a class method on Ronin::DB::URL" do
        expect(Ronin::DB::URL).to respond_to(:with_query_param_value)
      end
    end
  end
end
