require 'spec_helper'
require 'ronin/db/cli/commands/street_addresses'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::StreetAddresses do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.parse_options(argv) }

    describe "--for-person FULL_NAME" do
      let(:full_name) { 'John Doe' }
      let(:argv) { ['--for-person', full_name] }

      it "must append :for_person and the FULL_NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_person, [full_name]]
        )
      end

      it "and .for_person must be a class method on Ronin::DB::StreetAddress" do
        expect(Ronin::DB::StreetAddress).to respond_to(:for_person)
      end
    end

    describe "--for-organization NAME" do
      let(:name) { 'Acme Corp' }
      let(:argv) { ['--for-organization', name] }

      it "must append :for_organization and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_organization, [name]]
        )
      end

      it "and .for_organization must be a class method on Ronin::DB::StreetAddress" do
        expect(Ronin::DB::StreetAddress).to respond_to(:for_organization)
      end
    end

    describe "--with-address ADDRESS" do
      let(:address) { '123 Main St' }
      let(:argv) { ['--with-address', address] }

      it "must append :with_address and the ADDRESS to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_address, [address]]
        )
      end

      it "and .with_address must be a class method on Ronin::DB::StreetAddress" do
        expect(Ronin::DB::StreetAddress).to respond_to(:with_address)
      end
    end

    describe "--with-city CITY" do
      let(:city) { 'New York' }
      let(:argv) { ['--with-city', city] }

      it "must append :with_city and the CITY to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_city, [city]]
        )
      end

      it "and .with_city must be a class method on Ronin::DB::StreetAddress" do
        expect(Ronin::DB::StreetAddress).to respond_to(:with_city)
      end
    end

    describe "--with-state STATE" do
      let(:state) { 'California' }
      let(:argv) { ['--with-state', state] }

      it "must append :with_state and the STATE to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_state, [state]]
        )
      end

      it "and .with_state must be a class method on Ronin::DB::StreetAddress" do
        expect(Ronin::DB::StreetAddress).to respond_to(:with_state)
      end
    end

    describe "--with-country COUNTRY" do
      let(:country) { 'USA' }
      let(:argv) { ['--with-country', country] }

      it "must append :with_country and the COUNTRY to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_country, [country]]
        )
      end

      it "and .with_country must be a class method on Ronin::DB::StreetAddress" do
        expect(Ronin::DB::StreetAddress).to respond_to(:with_country)
      end
    end

    describe "--with-zipcode ZIPCODE" do
      let(:zipcode) { '90210' }
      let(:argv) { ['--with-zipcode', zipcode] }

      it "must append :with_zipcode and the ZIPCODE to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_zipcode, [zipcode]]
        )
      end

      it "and .with_zipcode must be a class method on Ronin::DB::StreetAddress" do
        expect(Ronin::DB::StreetAddress).to respond_to(:with_zipcode)
      end
    end
  end
end
