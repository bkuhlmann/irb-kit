# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Commands::Descendants do
  using Refinements::StringIO

  subject(:command) { described_class.new IRB.conf, handler: }

  let(:handler) { instance_spy IRB::Kit::Handlers::Descender }

  describe "#execute" do
    it "delegates to handler" do
      command.execute "Integer"
      expect(handler).to have_received(:call).with("Integer")
    end
  end
end
