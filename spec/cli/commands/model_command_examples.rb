require 'rspec'

RSpec.shared_examples_for "ModelCommand" do
  describe "model_file" do
    subject { described_class }

    it "must define a model_file" do
      expect(subject.model_file).to be_kind_of(String)
      expect(subject.model_file).to match(%r{\Aronin/db/[a-z0-9_]+\z})
    end

    it "must be a requirable file" do
      expect {
        require subject.model_file
      }.to_not raise_error
    end
  end

  describe "model_name" do
    subject { described_class }

    it "must define a model_name" do
      expect(subject.model_name).to be_kind_of(String)
      expect(subject.model_name).to match(/\A[A-Z][A-Za-z0-9]+\z/)
    end

    it "must be a valid constant within Ronin::DB" do
      expect(Ronin::DB.const_defined?(subject.model_name)).to be(true)
    end

    it "must be a kind of ActiveRecord::Base class" do
      expect(Ronin::DB.const_get(subject.model_name)).to be < ActiveRecord::Base
    end
  end
end
