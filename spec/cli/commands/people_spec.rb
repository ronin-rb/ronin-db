require 'spec_helper'
require 'ronin/db/cli/commands/people'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::People do
  include_examples "man_page"
  include_examples "ModelCommand"

  describe "options" do
    before { subject.parse_options(argv) }

    describe "--for-address ADDRESS" do
      let(:address) { '123 Main St' }
      let(:argv) { ['--for-address', address] }

      it "must append :for_address and the ADDRESS to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_address, [address]]
        )
      end

      it "and .for_address must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:for_address)
      end
    end

    describe "--for-city CITY" do
      let(:city) { 'New York' }
      let(:argv) { ['--for-city', city] }

      it "must append :for_city and the CITY to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_city, [city]]
        )
      end

      it "and .for_city must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:for_city)
      end
    end

    describe "--for-state STATE" do
      let(:state) { 'California' }
      let(:argv) { ['--for-state', state] }

      it "must append :for_state and the STATE to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_state, [state]]
        )
      end

      it "and .for_state must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:for_state)
      end
    end

    describe "--for-province PROVINCE" do
      let(:province) { 'Ontario' }
      let(:argv) { ['--for-province', province] }

      it "must append :for_province and the PROVINCE to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_province, [province]]
        )
      end

      it "and .for_province must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:for_province)
      end
    end

    describe "--for-zipcode ZIPCODE" do
      let(:zipcode) { '90210' }
      let(:argv) { ['--for-zipcode', zipcode] }

      it "must append :for_zipcode and the ZIPCODE to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_zipcode, [zipcode]]
        )
      end

      it "and .for_zipcode must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:for_zipcode)
      end
    end

    describe "--for-country COUNTRY" do
      let(:country) { 'USA' }
      let(:argv) { ['--for-country', country] }

      it "must append :for_country and the COUNTRY to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:for_country, [country]]
        )
      end

      it "and .for_country must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:for_country)
      end
    end

    describe "--with-prefix PREFIX" do
      let(:prefix) { 'Dr' }
      let(:argv) { ['--with-prefix', prefix] }

      it "must append :with_prefix and the PREFIX to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_prefix, [prefix]]
        )
      end

      it "and .with_prefix must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:with_prefix)
      end
    end

    describe "--with-first-name NAME" do
      let(:name) { 'John' }
      let(:argv) { ['--with-first-name', name] }

      it "must append :with_first_name and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_first_name, [name]]
        )
      end

      it "and .with_first_name must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:with_first_name)
      end
    end

    describe "--with-middle-name NAME" do
      let(:name) { 'Michael' }
      let(:argv) { ['--with-middle-name', name] }

      it "must append :with_middle_name and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_middle_name, [name]]
        )
      end

      it "and .with_middle_name must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:with_middle_name)
      end
    end

    describe "--with-middle-initial INITIAL" do
      let(:initial) { 'J' }
      let(:argv) { ['--with-middle-initial', initial] }

      it "must append :with_middle_initial and the INITIAL to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_middle_initial, [initial]]
        )
      end

      it "and .with_middle_initial must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:with_middle_initial)
      end
    end

    describe "--with-last-name NAME" do
      let(:name) { 'Smith' }
      let(:argv) { ['--with-last-name', name] }

      it "must append :with_last_name and the NAME to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_last_name, [name]]
        )
      end

      it "and .with_last_name must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:with_last_name)
      end
    end

    describe "--with-suffix SUFFIX" do
      let(:suffix) { 'Jr' }
      let(:argv) { ['--with-suffix', suffix] }

      it "must append :with_suffix and the SUFFIX to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_suffix, [suffix]]
        )
      end

      it "and .with_suffix must be a class method on Ronin::DB::Person" do
        expect(Ronin::DB::Person).to respond_to(:with_suffix)
      end
    end
  end
end
