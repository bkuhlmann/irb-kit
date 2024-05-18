# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Search do
  subject(:helper) { described_class.instance }

  describe "#execute" do
    it "answers methods for string pattern" do
      expect(helper.execute(Method, "private")).to eq(
        %i[
          private_instance_methods
          private_constant
          private_method_defined?
          private_class_method
          private_methods
        ]
      )
    end

    it "answers methods for regular expression pattern" do
      expect(helper.execute(Method, /private.*\?/)).to contain_exactly(:private_method_defined?)
    end

    it "answers empty array if pattern doesn't match" do
      expect(helper.execute(Method, "bogus")).to eq([])
    end

    it "answers type error when using a symbol" do
      expect(helper.execute(Method, :bogus)).to eq(
        "ERROR: Use only a string or regular expression for the pattern."
      )
    end
  end
end
