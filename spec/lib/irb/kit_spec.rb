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

  describe ".register_commands" do
    let :actual do
      IRB::Command.commands
                  .reject { |key, _value| key.match?(/(irb|cd|copy)/) }
                  .map { |key, _value| key }
    end

    it "registers the maximum" do
      described_class.register_commands :all
      expected = IRB::Kit::Commands.constants.map(&:downcase)

      expect(actual).to eq(expected)
    end

    it "registers a specific command" do
      described_class.register_commands :descendants
      expect(actual).to contain_exactly(:descendants)
    end
  end

  describe ".register_helpers" do
    let :actual do
      IRB::HelperMethod.all_helper_methods_info.pluck(:display_name).tap do |helpers|
        helpers.delete :conf
      end
    end

    before { IRB::HelperMethod.helper_methods.clear }

    it "registers the maximum" do
      described_class.register_helpers :all

      expected = IRB::Kit::Helpers.constants.sort.map do |name|
        IRB::Kit::Helpers.const_get(name)::MONIKER
      end

      expect(actual).to eq(expected)
    end

    it "registers specific helper" do
      described_class.register_helpers :clip
      expect(actual).to contain_exactly(:clip)
    end
  end

  describe ".prompt" do
    it "answers prompt" do
      expect(described_class.prompt).to match(/\d+\.\d+\.\d+\|(irb-kit|project)/)
    end
  end
end
