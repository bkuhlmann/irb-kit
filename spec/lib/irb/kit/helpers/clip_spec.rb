# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Clip do
  subject(:helper) { described_class.instance }

  let(:io) { class_spy IO }

  before { helper.instance_variable_set :@io, io }

  describe "#execute" do
    it "messages pbcopy" do
      helper.execute
      expect(io).to have_received(:popen).with("pbcopy", "w")
    end

    it "fails with error when pbcopy isn't found" do
      allow(io).to receive(:popen).with("pbcopy", "w").and_raise Errno::ENOENT, "Danger!"
      expect(helper.execute).to include("`pbcopy` is only supported on macOS")
    end
  end
end
