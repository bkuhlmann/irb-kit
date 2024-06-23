# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::MethodEditor do
  subject(:handler) { described_class.new editor:, io: }

  let(:editor) { instance_spy IRB::Kit::Handlers::Editor }
  let(:io) { instance_spy IO }

  describe "#call" do
    it "delegated to editor" do
      handler.call IRB, :start
      expect(editor).to have_received(:call).with(/irb.rb/, 893)
    end

    it "prints error when undefined" do
      handler.call IRB, :bogus
      expect(io).to have_received(:puts).with("ERROR: Undefined method `:bogus` for `IRB`.")
    end
  end
end
