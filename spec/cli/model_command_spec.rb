require 'spec_helper'
require 'ronin/db/cli/model_command'
require 'ronin/db/ip_address'
require 'ronin/db/host_name'

describe Ronin::DB::CLI::ModelCommand do
  it "must inherit from Ronin::DB::CLI::DatabaseCommand" do
    expect(described_class).to be < Ronin::DB::CLI::DatabaseCommand
  end

  describe ".model_file" do
    subject { test_class }

    context "and when model_file is not set in the class" do
      module TestModelCommand
        class WithNoModelFileSet < Ronin::DB::CLI::ModelCommand
        end
      end

      let(:test_class) { TestModelCommand::WithNoModelFileSet }

      it do
        expect {
          subject.model_file
        }.to raise_error(NotImplementedError,"#{subject} did not define model_file")
      end
    end

    context "and when model_file is set in the class" do
      module TestModelCommand
        class WithModelFileSet < Ronin::DB::CLI::ModelCommand
          model_file 'ronin/db/test'
        end
      end

      let(:test_class) { TestModelCommand::WithModelFileSet }

      it "must return the set model_file" do
        expect(subject.model_file).to eq('ronin/db/test')
      end
    end

    context "but when the model_file was set in the superclass" do
      module TestModelCommand
        class InheritsItsModelFile < WithModelFileSet
        end
      end

      let(:test_class) { TestModelCommand::InheritsItsModelFile }

      it "must return the model_file set in the superclass" do
        expect(subject.model_file).to eq('ronin/db/test')
      end

      context "but the model_file is overridden in the sub-class" do
        module TestModelCommand
          class OverridesItsInheritedModelFile < WithModelFileSet
            model_file 'ronin/db/test2'
          end
        end

        let(:test_class) do
          TestModelCommand::OverridesItsInheritedModelFile
        end

        it "must return the model_file set in the sub-class" do
          expect(subject.model_file).to eq('ronin/db/test2')
        end

        it "must not modify the superclass'es model_file" do
          expect(subject.superclass.model_file).to eq('ronin/db/test')
        end
      end
    end
  end

  describe ".model_name" do
    subject { test_class }

    context "and when model_name is not set in the class" do
      module TestModelCommand
        class WithNoModelNameSet < Ronin::DB::CLI::ModelCommand
        end
      end

      let(:test_class) { TestModelCommand::WithNoModelNameSet }

      it do
        expect {
          subject.model_name
        }.to raise_error(NotImplementedError,"#{subject} did not define model_name")
      end
    end

    context "and when model_name is set in the class" do
      module TestModelCommand
        class WithModelNameSet < Ronin::DB::CLI::ModelCommand
          model_name 'Test'
        end
      end

      let(:test_class) { TestModelCommand::WithModelNameSet }

      it "must return the set model_name" do
        expect(subject.model_name).to eq('Test')
      end
    end

    context "but when the model_name was set in the superclass" do
      module TestModelCommand
        class InheritsItsModelName < WithModelNameSet
        end
      end

      let(:test_class) { TestModelCommand::InheritsItsModelName }

      it "must return the model_name set in the superclass" do
        expect(subject.model_name).to eq('Test')
      end

      context "but the model_name is overridden in the sub-class" do
        module TestModelCommand
          class OverridesItsInheritedModelName < WithModelNameSet
            model_name 'Test2'
          end
        end

        let(:test_class) do
          TestModelCommand::OverridesItsInheritedModelName
        end

        it "must return the model_name set in the sub-class" do
          expect(subject.model_name).to eq('Test2')
        end

        it "must not modify the superclass'es model_name" do
          expect(subject.superclass.model_name).to eq('Test')
        end
      end
    end
  end

  describe ".model_name"

  module TestModelCommand
    class TestCommand < Ronin::DB::CLI::ModelCommand
      model_file 'ronin/db/ip_address'
      model_name 'IPAddress'
    end
  end

  let(:test_command) { TestModelCommand::TestCommand }
  subject { test_command.new }

  describe "#initialize" do
    it "must initialize #query_method_calls to an empty Array" do
      expect(subject.query_method_calls).to eq([])
    end
  end

  describe "#model" do
    it "must resolve the class for the model within Ronin::DB::" do
      expect(subject.model).to be(Ronin::DB.const_get(subject.class.model_name))
    end
  end

  describe "#query" do
    let(:host)   { 'example.com'   }
    let(:ipv4)   { '93.184.216.34' }
    let(:ipv6)   { '2606:2800:220:1:248:1893:25c8:1946' }

    before do
      host_name = Ronin::DB::HostName.create(name: host)

      Ronin::DB::IPAddress.create(address: '127.0.0.1', version: 4)
      Ronin::DB::IPAddress.create(
        address:    ipv4,
        version:    4,
        host_names: [host_name]
      )
      Ronin::DB::IPAddress.create(
        address:    ipv6,
        version:    6,
        host_names: [host_name]
      )
      Ronin::DB::IPAddress.create(address: '::1', version: 6)
    end

    context "when #query_method_calls is empty" do
      it "must return a ActiveRecord_Relation object" do
        expect(subject.query).to be_kind_of(
          subject.model.const_get('ActiveRecord_Relation')
        )
      end
    end

    context "when #query_method_calls contains a :where method call" do
      before do
        subject.query_method_calls << [:where, [], {version: 4}]
      end

      it "must invoke #where with the given arguments on the query" do
        expect(subject.query).to eq(
          Ronin::DB::IPAddress.where(version: 4)
        )
      end
    end

    context "when #query_method_calls contains a scoped query method call" do
      before do
        subject.query_method_calls << [:with_host_name, [host]]
      end

      it "must invoke the scoped query method on the query" do
        expect(subject.query).to eq(
          Ronin::DB::IPAddress.with_host_name(host)
        )
      end
    end

    after do
      Ronin::DB::IPAddress.destroy_all
      Ronin::DB::HostName.destroy_all
    end
  end

  describe "#print_record" do
    let(:record) { Ronin::DB::IPAddress.new(address: '127.0.0.1') }

    it "must print the record using #puts" do
      expect {
        subject.print_record(record)
      }.to output("#{record}#{$/}").to_stdout
    end
  end
end
