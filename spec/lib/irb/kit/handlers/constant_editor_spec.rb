# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::ConstantEditor do
  subject(:handler) { described_class.new editor:, io: }

  let(:editor) { instance_spy IRB::Kit::Handlers::Editor }
  let(:io) { instance_spy IO }

  describe "#call" do
    it "delegated to editor" do
      handler.call "IRB::IRBRC_EXT"
      expect(editor).to have_received(:call).with(/init.rb/, kind_of(Integer))
    end

    it "prints error when invalid" do
      handler.call :foo
      expect(io).to have_received(:puts).with("ERROR (invalid constant): :foo.")
    end
  end
end
