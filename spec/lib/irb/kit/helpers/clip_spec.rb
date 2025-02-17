# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Clip do
  subject(:helper) { described_class.instance }

  let(:handler) { instance_spy IRB::Kit::Handlers::Clipper }

  before { helper.instance_variable_set :@handler, handler }

  describe "#execute" do
    it "prints deprecation warning" do
      expectation = proc { helper.execute "test" }
      message = "`clip` is deprecated, use IRB's native `copy` helper instead.\n"

      expect(&expectation).to output(message).to_stderr
    end

    it "delegates to handler" do
      helper.execute "test"
      expect(handler).to have_received(:call).with("test")
    end
  end
end
