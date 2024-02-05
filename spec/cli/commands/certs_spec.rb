require 'spec_helper'
require 'ronin/db/cli/commands/certs'
require_relative 'man_page_example'
require_relative 'model_command_examples'

require 'ronin/db/cert'

describe Ronin::DB::CLI::Commands::Certs do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.option_parser.parse(argv) }

    describe "--active" do
      let(:argv) { ['--active'] }

      it "must append :active to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:active]
        )
      end

      it "and .active must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:active)
      end
    end

    describe "--expired" do
      let(:argv) { ['--expired'] }

      it "must append :expired to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:expired]
        )
      end

      it "and .expired must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:expired)
      end
    end

    describe "--issuer-common-name NAME" do
      let(:name) { 'Cert Co.' }
      let(:argv) { ['--issuer-common-name', name] }

      it "must append :with_issuer_common_name and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_issuer_common_name, [name]]
        )
      end

      it "and .with_issuer_common_name must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_issuer_common_name)
      end
    end

    describe "--issuer-organization NAME" do
      let(:name) { 'Cert Co.' }
      let(:argv) { ['--issuer-organization', name] }

      it "must append :with_issuer_organization and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_issuer_organization, [name]]
        )
      end

      it "and .with_issuer_organization must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_issuer_organization)
      end
    end

    describe "--issuer-organizational-unit NAME" do
      let(:name) { 'Cert Dept.' }
      let(:argv) { ['--issuer-organizational-unit', name] }

      it "must append :with_issuer_organizational_unit and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_issuer_organizational_unit, [name]]
        )
      end

      it "and .with_issuer_organizational_unit must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_issuer_organizational_unit)
      end
    end

    describe "--issuer-locality LOCALITY" do
      let(:locality) { 'City' }
      let(:argv)     { ['--issuer-locality', locality] }

      it "must append :with_issuer_locality and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_issuer_locality, [locality]]
        )
      end

      it "and .with_issuer_locality must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_issuer_locality)
      end
    end

    describe "--issuer-state STATE" do
      let(:state) { 'ST' }
      let(:argv)  { ['--issuer-state', state] }

      it "must append :with_issuer_state and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_issuer_state, [state]]
        )
      end

      it "and .with_issuer_state must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_issuer_state)
      end
    end

    describe "--issuer-country COUNTRY" do
      let(:country) { 'US' }
      let(:argv)    { ['--issuer-country', country] }

      it "must append :with_issuer_country and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_issuer_country, [country]]
        )
      end

      it "and .with_issuer_country must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_issuer_country)
      end
    end

    describe "--common-name HOST" do
      let(:host) { 'example.com' }
      let(:argv) { ['--common-name', host] }

      it "must append :with_common_name and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_common_name, [host]]
        )
      end

      it "and .with_common_name must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_common_name)
      end
    end

    describe "--subject-alt-name HOST" do
      let(:host) { 'www.example.com' }
      let(:argv) { ['--subject-alt-name', host] }

      it "must append :with_subject_alt_name and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_subject_alt_name, [host]]
        )
      end

      it "and .with_subject_alt_name must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_subject_alt_name)
      end
    end

    describe "--organization NAME" do
      let(:name) { 'Cert Co.' }
      let(:argv) { ['--organization', name] }

      it "must append :with_organization and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_organization, [name]]
        )
      end

      it "and .with_organization must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_organization)
      end
    end

    describe "--organizational-unit NAME" do
      let(:name) { 'Cert Dept.' }
      let(:argv) { ['--organizational-unit', name] }

      it "must append :with_organizational_unit and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_organizational_unit, [name]]
        )
      end

      it "and .with_organizational_unit must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_organizational_unit)
      end
    end

    describe "--locality LOCALITY" do
      let(:locality) { 'City' }
      let(:argv)     { ['--locality', locality] }

      it "must append :with_locality and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_locality, [locality]]
        )
      end

      it "and .with_locality must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_locality)
      end
    end

    describe "--state STATE" do
      let(:state) { 'ST' }
      let(:argv)  { ['--state', state] }

      it "must append :with_state and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_state, [state]]
        )
      end

      it "and .with_state must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_state)
      end
    end

    describe "--country COUNTRY" do
      let(:country) { 'US' }
      let(:argv)    { ['--country', country] }

      it "must append :with_country and the name to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_country, [country]]
        )
      end

      it "and .with_country must be a class method on Ronin::DB::Cert" do
        expect(Ronin::DB::Cert).to respond_to(:with_country)
      end
    end
  end
end
