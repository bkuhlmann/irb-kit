# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::Descender do
  subject(:handler) { described_class.new io: }

  let(:io) { instance_spy IO }

  describe "#call" do
    it "prints descendants" do
      handler.call "IO"
      expect(io).to have_received(:puts).with("File")
    end

    it "prints sorted descendants" do
      handler.call "Ractor::Error"

      expect(io).to have_received(:puts).with(<<~CONTENT.strip)
        Ractor::IsolationError
        Ractor::MovedError
        Ractor::RemoteError
        Ractor::UnsafeError
      CONTENT
    end

    it "prints no descendants when none are found" do
      handler.call "Integer"
      expect(io).to have_received(:puts).with("No descendants found.")
    end

    it "prints error when class can't be found" do
      handler.call "bogus"
      expect(io).to have_received(:puts).with(%(ERROR: "bogus" doesn't exist.))
    end
  end
end
