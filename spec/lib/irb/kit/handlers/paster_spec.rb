# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::Paster do
  subject(:handler) { described_class.new processor:, io: }

  let(:processor) { class_spy IO }
  let(:io) { instance_spy IO }

  describe "#call" do
    it "messages pbpaste" do
      handler.call
      expect(processor).to have_received(:popen).with("pbpaste", "r")
    end

    it "prints error when pbpaste isn't found" do
      allow(processor).to receive(:popen).with("pbpaste", "r").and_raise Errno::ENOENT, "Danger!"
      handler.call

      expect(io).to have_received(:puts).with(
        "ERROR: Unable to paste since `pbpaste` is only supported on macOS."
      )
    end
  end
end
