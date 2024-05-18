# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Paste do
  subject(:helper) { described_class.instance }

  describe "#execute" do
    it "answers last entry in clipboard" do
      skip "Requires macOS." if ENV.fetch("CI", false) == "true"

      IO.popen("pbcopy", "w") { |clipboard| clipboard.write "IRB Kit Test" }
      expect(helper.execute).to eq("IRB Kit Test")
    end
  end
end
