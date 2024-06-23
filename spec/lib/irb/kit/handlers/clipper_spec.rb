# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::Clipper do
  subject(:handler) { described_class.new processor:, io: }

  let(:io) { instance_spy IO }
  let(:processor) { class_spy IO }

  describe "#call" do
    it "messages pbcopy" do
      handler.call
      expect(processor).to have_received(:popen).with("pbcopy", "w")
    end

    it "prints information" do
      handler.call
      expect(io).to have_received(:puts).with("Copied to clipboard.")
    end

    it "prints error when pbcopy isn't found" do
      allow(processor).to receive(:popen).with("pbcopy", "w").and_raise Errno::ENOENT, "Danger!"
      handler.call

      expect(io).to have_received(:puts).with(
        "ERROR: Unable to copy since `pbcopy` is only supported on macOS."
      )
    end
  end
end
