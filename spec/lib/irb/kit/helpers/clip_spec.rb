# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Clip do
  subject(:helper) { described_class.instance }

  describe "#execute" do
    it "answers size of copied content" do
      skip "Requires macOS." if ENV.fetch("CI", false) == "true"

      expect(helper.execute("A test.")).to eq(7)
    end
  end
end
