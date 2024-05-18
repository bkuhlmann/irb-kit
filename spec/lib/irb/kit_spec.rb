# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit do
  describe ".loader" do
    it "eager loads" do
      expectation = proc { described_class.loader.eager_load force: true }
      expect(&expectation).not_to raise_error
    end

    it "answers unique tag" do
      expect(described_class.loader.tag).to eq("irb-kit")
    end
  end

  describe ".register_helpers" do
    it "loads all helpers" do
      described_class.register_helpers :all

      expect(IRB::HelperMethod.all_helper_methods_info).to eq(
        [
          {display_name: :conf, description: "Returns the current IRB context."},
          {display_name: :clip, description: "Copy input to macOS clipboard."},
          {display_name: :csource, description: "Find a constant's source location."},
          {display_name: :msource, description: "Find an object method's source location."},
          {display_name: :paste, description: "Paste last entry from macOS clipboard."},
          {display_name: :search, description: "Search an object's methods by pattern."}
        ]
      )
    end
  end

  describe ".prompt" do
    it "answers prompt" do
      expect(described_class.prompt).to match(/\d+\.\d+\.\d+\|(irb-kit|project)/)
    end
  end
end
