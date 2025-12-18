require 'spec_helper'
require 'ronin/db/cli/commands/phone_numbers'
require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::PhoneNumbers do
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

      it "and .for_person must be a class method on Ronin::DB::PhoneNumber" do
        expect(Ronin::DB::PhoneNumber).to respond_to(:for_person)
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

      it "and .for_organization must be a class method on Ronin::DB::PhoneNumber" do
        expect(Ronin::DB::PhoneNumber).to respond_to(:for_organization)
      end
    end

    describe "--with-country-code NUM" do
      let(:country_code) { '1' }
      let(:argv) { ['--with-country-code', country_code] }

      it "must append :with_country_code and the NUM to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_country_code, country_code]
        )
      end

      it "and .with_country_code must be a class method on Ronin::DB::PhoneNumber" do
        expect(Ronin::DB::PhoneNumber).to respond_to(:with_country_code)
      end
    end

    describe "--with-area-code NUM" do
      let(:area_code) { '212' }
      let(:argv) { ['--with-area-code', area_code] }

      it "must append :with_area_code and the NUM to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_area_code, area_code]
        )
      end

      it "and .with_area_code must be a class method on Ronin::DB::PhoneNumber" do
        expect(Ronin::DB::PhoneNumber).to respond_to(:with_area_code)
      end
    end

    describe "--with-prefix NUM" do
      let(:prefix) { '555' }
      let(:argv) { ['--with-prefix', prefix] }

      it "must append :with_prefix and the NUM to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_prefix, prefix]
        )
      end

      it "and .with_prefix must be a class method on Ronin::DB::PhoneNumber" do
        expect(Ronin::DB::PhoneNumber).to respond_to(:with_prefix)
      end
    end

    describe "--with-line-number NUM" do
      let(:line_number) { '1234' }
      let(:argv) { ['--with-line-number', line_number] }

      it "must append :with_line_number and the NUM to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:with_line_number, line_number]
        )
      end

      it "and .with_line_number must be a class method on Ronin::DB::PhoneNumber" do
        expect(Ronin::DB::PhoneNumber).to respond_to(:with_line_number)
      end
    end

    describe "--similar-to PHONE_NUMBER" do
      let(:number) { '555-1234' }
      let(:argv) { ['--similar-to', number] }

      it "must append :similar_to and the PHONE_NUMBER to #query_method_calls" do
        expect(subject.query_method_calls[-1]).to eq(
          [:similar_to, number]
        )
      end

      it "and .similar_to must be a class method on Ronin::DB::PhoneNumber" do
        expect(Ronin::DB::PhoneNumber).to respond_to(:similar_to)
      end
    end
  end
end
