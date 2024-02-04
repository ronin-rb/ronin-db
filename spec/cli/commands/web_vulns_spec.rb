require 'spec_helper'
require 'ronin/db/cli/commands/web_vulns'
require 'ronin/db/url'

require_relative 'man_page_example'
require_relative 'model_command_examples'

describe Ronin::DB::CLI::Commands::WebVulns do
  include_examples "man_page"
  include_examples "ModelCommand"

  let(:url) { Ronin::DB::URL.import('https://example.com/page.php?id=1') }

  let(:type)           { 'sqli' }
  let(:request_method) { :get }
  let(:query_param)    { 'id' }
  let(:header_name)    { nil }
  let(:cookie_param)   { nil }
  let(:form_param)     { nil }

  let(:web_vuln) do
    Ronin::DB::WebVuln.create(
      type: type,
      url:  url,

      request_method: request_method,
      query_param:    query_param,
      header_name:    header_name,
      cookie_param:   cookie_param,
      form_param:     form_param
    )
  end

  after do
    Ronin::DB::URL.destroy_all
    Ronin::DB::WebVuln.destroy_all
  end

  describe "#web_vuln_type" do
    context "when given a Ronin::Vulns::LFI object" do
      let(:type) { 'lfi' }

      it "must return 'LFI'" do
        expect(subject.web_vuln_type(web_vuln)).to eq('LFI')
      end
    end

    context "when given a Ronin::Vulns::RFI object" do
      let(:type) { 'rfi' }

      it "must return 'RFI'" do
        expect(subject.web_vuln_type(web_vuln)).to eq('RFI')
      end
    end

    context "when given a Ronin::Vulns::SQLI object" do
      let(:type) { 'sqli' }

      it "must return 'SQLi'" do
        expect(subject.web_vuln_type(web_vuln)).to eq('SQLi')
      end
    end

    context "when given a Ronin::Vulns::SSTI object" do
      let(:type) { 'ssti' }

      it "must return 'SSTI'" do
        expect(subject.web_vuln_type(web_vuln)).to eq('SSTI')
      end
    end

    context "when given a Ronin::Vulns::OpenRedirect object" do
      let(:type) { 'open_redirect' }

      it "must return 'Open Redirect'" do
        expect(subject.web_vuln_type(web_vuln)).to eq('Open Redirect')
      end
    end

    context "when given a Ronin::Vulns::ReflectedXSS object" do
      let(:type) { 'reflected_xss' }

      it "must return 'Reflected XSS'" do
        expect(subject.web_vuln_type(web_vuln)).to eq('Reflected XSS')
      end
    end
  end

  describe "#web_vuln_location" do
    context "and the #query_param attribute is set" do
      it "must return 'query param <query_param>'" do
        expect(subject.web_vuln_location(web_vuln)).to eq(
          "query param '#{query_param}'"
        )
      end
    end

    context "and the #header_name attribute is set" do
      let(:query_param) { nil }
      let(:header_name) { 'X-Foo' }

      it "must return 'Header <header_name>'" do
        expect(subject.web_vuln_location(web_vuln)).to eq(
          "Header '#{header_name}'"
        )
      end
    end

    context "and the #cookie_param attribute is set" do
      let(:query_param)  { nil }
      let(:cookie_param) { 'X-Foo' }

      it "must return 'Cookie param <cookie_param>'" do
        expect(subject.web_vuln_location(web_vuln)).to eq(
          "Cookie param '#{cookie_param}'"
        )
      end
    end

    context "and the #form_param attribute is set" do
      let(:query_param) { nil }
      let(:form_param)  { 'X-Foo' }

      it "must return 'form param <form_param>'" do
        expect(subject.web_vuln_location(web_vuln)).to eq(
          "form param '#{form_param}'"
        )
      end
    end
  end

  describe "#print_record" do
    context "when the Ronin::DB::WebVuln#type is 'lfi'" do
      let(:type) { 'lfi' }

      context "and the #query_param attribute is set" do
        it "must print 'LFI on <url> via query param <query_param>'" do
          expect(subject).to receive(:puts).with(
            "LFI on #{url} via query param '#{query_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:query_param) { nil }
        let(:header_name) { 'X-Foo' }

        it "must print 'LFI on <url> via Header <header_name>'" do
          expect(subject).to receive(:puts).with(
            "LFI on #{url} via Header '#{header_name}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:query_param)  { nil }
        let(:cookie_param) { 'X-Foo' }

        it "must print 'LFI on <url> via Cookie param <cookie_param>'" do
          expect(subject).to receive(:puts).with(
            "LFI on #{url} via Cookie param '#{cookie_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:query_param) { nil }
        let(:form_param)  { 'X-Foo' }

        it "must print 'LFI on <url> via form param <form_param>'" do
          expect(subject).to receive(:puts).with(
            "LFI on #{url} via form param '#{form_param}'"
          )

          subject.print_record(web_vuln)
        end
      end
    end

    context "when given the Ronin::DB::WebVuln#type is 'rfi'" do
      let(:type) { 'rfi' }

      context "and the #query_param attribute is set" do
        it "must print 'RFI on <url> via query param <query_param>'" do
          expect(subject).to receive(:puts).with(
            "RFI on #{url} via query param '#{query_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:query_param) { nil }
        let(:header_name) { 'X-Foo' }

        it "must print 'RFI on <url> via Header <header_name>'" do
          expect(subject).to receive(:puts).with(
            "RFI on #{url} via Header '#{header_name}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:query_param)  { nil }
        let(:cookie_param) { 'X-Foo' }

        it "must print 'RFI on <url> via Cookie param <cookie_param>'" do
          expect(subject).to receive(:puts).with(
            "RFI on #{url} via Cookie param '#{cookie_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:query_param) { nil }
        let(:form_param)  { 'X-Foo' }

        it "must print 'RFI on <url> via form param <form_param>'" do
          expect(subject).to receive(:puts).with(
            "RFI on #{url} via form param '#{form_param}'"
          )

          subject.print_record(web_vuln)
        end
      end
    end

    context "when the Ronin::DB::WebVuln is 'sqli'" do
      let(:type) { 'sqli' }

      context "and the #query_param attribute is set" do
        it "must print 'SQLI on <url> via query param <query_param>'" do
          expect(subject).to receive(:puts).with(
            "SQLi on #{url} via query param '#{query_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:query_param) { nil }
        let(:header_name) { 'X-Foo' }

        it "must print 'SQLI on <url> via Header <header_name>'" do
          expect(subject).to receive(:puts).with(
            "SQLi on #{url} via Header '#{header_name}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:query_param)  { nil }
        let(:cookie_param) { 'X-Foo' }

        it "must print 'SQLI on <url> via Cookie param <cookie_param>'" do
          expect(subject).to receive(:puts).with(
            "SQLi on #{url} via Cookie param '#{cookie_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:query_param) { nil }
        let(:form_param)  { 'X-Foo' }

        it "must print 'SQLI on <url> via form param <form_param>'" do
          expect(subject).to receive(:puts).with(
            "SQLi on #{url} via form param '#{form_param}'"
          )

          subject.print_record(web_vuln)
        end
      end
    end

    context "when the Ronin::DB::WebVuln#type is 'ssti'" do
      let(:type) { 'ssti' }

      context "and the #query_param attribute is set" do
        it "must print 'SSTI on <url> via query param <query_param>'" do
          expect(subject).to receive(:puts).with(
            "SSTI on #{url} via query param '#{query_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:query_param) { nil }
        let(:header_name) { 'X-Foo' }

        it "must print 'SSTI on <url> via Header <header_name>'" do
          expect(subject).to receive(:puts).with(
            "SSTI on #{url} via Header '#{header_name}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:query_param)  { nil }
        let(:cookie_param) { 'X-Foo' }

        it "must print 'SSTI on <url> via Cookie param <cookie_param>'" do
          expect(subject).to receive(:puts).with(
            "SSTI on #{url} via Cookie param '#{cookie_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:query_param) { nil }
        let(:form_param)  { 'X-Foo' }

        it "must print 'SSTI on <url> via form param <form_param>'" do
          expect(subject).to receive(:puts).with(
            "SSTI on #{url} via form param '#{form_param}'"
          )

          subject.print_record(web_vuln)
        end
      end
    end

    context "when the Ronin::DB::WebVuln#type is 'open_redirect'" do
      let(:type) { 'open_redirect' }

      context "and the #query_param attribute is set" do
        it "must print 'Open Redirect on <url> via query param <query_param>'" do
          expect(subject).to receive(:puts).with(
            "Open Redirect on #{url} via query param '#{query_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:query_param) { nil }
        let(:header_name) { 'X-Foo' }

        it "must print 'Open Redirect on <url> via Header <header_name>'" do
          expect(subject).to receive(:puts).with(
            "Open Redirect on #{url} via Header '#{header_name}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:query_param)  { nil }
        let(:cookie_param) { 'X-Foo' }

        it "must print 'Open Redirect on <url> via Cookie param <cookie_param>'" do
          expect(subject).to receive(:puts).with(
            "Open Redirect on #{url} via Cookie param '#{cookie_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:query_param) { nil }
        let(:form_param)  { 'X-Foo' }

        it "must print 'Open Redirect on <url> via form param <form_param>'" do
          expect(subject).to receive(:puts).with(
            "Open Redirect on #{url} via form param '#{form_param}'"
          )

          subject.print_record(web_vuln)
        end
      end
    end

    context "when the Ronin::DB::WebVuln#type is 'reflected_xss'" do
      let(:type) { 'reflected_xss' }

      context "and the #query_param attribute is set" do
        it "must print 'Reflected XSS on <url> via query param <query_param>'" do
          expect(subject).to receive(:puts).with(
            "Reflected XSS on #{url} via query param '#{query_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:query_param) { nil }
        let(:header_name) { 'X-Foo' }

        it "must print 'Reflected XSS on <url> via Header <header_name>'" do
          expect(subject).to receive(:puts).with(
            "Reflected XSS on #{url} via Header '#{header_name}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:query_param)  { nil }
        let(:cookie_param) { 'X-Foo' }

        it "must print 'Reflected XSS on <url> via Cookie param <cookie_param>'" do
          expect(subject).to receive(:puts).with(
            "Reflected XSS on #{url} via Cookie param '#{cookie_param}'"
          )

          subject.print_record(web_vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:query_param) { nil }
        let(:form_param)  { 'X-Foo' }

        it "must print 'Reflected XSS on <url> via form param <form_param>'" do
          expect(subject).to receive(:puts).with(
            "Reflected XSS on #{url} via form param '#{form_param}'"
          )

          subject.print_record(web_vuln)
        end
      end
    end
  end
end
