# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Paste do
  subject(:helper) { described_class.instance }

  let(:handler) { instance_spy IRB::Kit::Handlers::Paster }

  before { helper.instance_variable_set :@handler, handler }

  describe "#execute" do
    it "delegates to handler" do
      helper.execute
      expect(handler).to have_received(:call)
    end
  end
end
