# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::ConstantSource do
  subject(:helper) { described_class.instance }

  describe "#execute" do
    it "answers source location" do
      expect(helper.execute("RUBY_DESCRIPTION")).to match(/ruby:0/)
    end

    it "answers nil when there is no source" do
      expect(helper.execute("HOME")).to be(nil)
    end

    it "answers name error when constant is invalid" do
      expect(helper.execute(:foo)).to eq("ERROR: Invalid constant (:foo).")
    end
  end
end
