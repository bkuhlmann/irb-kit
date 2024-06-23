# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::Searcher do
  subject(:handler) { described_class.new io: }

  let(:io) { instance_spy IO }

  describe "#call" do
    it "prints matching methods for string" do
      handler.call Method, "private"

      expect(io).to have_received(:puts).with(<<~CONTENT.strip)
        private_instance_methods
        private_constant
        private_method_defined?
        private_class_method
        private_methods
      CONTENT
    end

    it "prints matching methods for regular expression" do
      handler.call(Method, /private.*\?/)
      expect(io).to have_received(:puts).with("private_method_defined?")
    end

    it "prints no matches when pattern doesn't match" do
      handler.call Method, "bogus"
      expect(io).to have_received(:puts).with("No matches found.")
    end

    it "prints error when using a symbol" do
      handler.call Method, :bogus

      expect(io).to have_received(:puts).with(
        "ERROR: Use only a string or regular expression for the pattern."
      )
    end
  end
end
