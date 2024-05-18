# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::ConstantSource do
  subject(:helper) { described_class.instance }

  describe "#execute" do
    it "answers source location" do
      expect(helper.execute("RUBY_DESCRIPTION")).to match(array_including(/.*ruby/, 0))
    end

    it "answers name error when constant is invalid" do
      expect(helper.execute(:foo)).to eq("ERROR: Invalid constant (:foo).")
    end
  end
end
