# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit do
  using Refinements::Array

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

      actual = IRB::HelperMethod.all_helper_methods_info.pluck(:display_name).tap do |helpers|
        helpers.delete :conf
      end

      expected = IRB::Kit::Helpers.constants.sort.map do |name|
        # rubocop:disable Style/MethodCallWithArgsParentheses
        IRB::Kit::Helpers.const_get(name)::MONIKER
        # rubocop:enable Style/MethodCallWithArgsParentheses
      end

      expect(actual).to eq(expected)
    end
  end

  describe ".prompt" do
    it "answers prompt" do
      expect(described_class.prompt).to match(/\d+\.\d+\.\d+\|(irb-kit|project)/)
    end
  end
end
