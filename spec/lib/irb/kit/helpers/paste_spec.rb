# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Paste do
  subject(:helper) { described_class.instance }

  let(:io) { class_spy IO }

  before { helper.instance_variable_set :@io, io }

  describe "#execute" do
    it "messages pbpaste" do
      helper.execute
      expect(io).to have_received(:popen).with("pbpaste", "r")
    end

    it "fails with error when pbpaste isn't found" do
      allow(io).to receive(:popen).with("pbpaste", "r").and_raise Errno::ENOENT, "Danger!"
      expect(helper.execute).to include("`pbpaste` is only supported on macOS")
    end
  end
end
