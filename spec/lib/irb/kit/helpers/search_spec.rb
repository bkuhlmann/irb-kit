# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::Search do
  subject(:helper) { described_class.instance }

  let(:handler) { instance_spy IRB::Kit::Handlers::Searcher }

  before { helper.instance_variable_set :@handler, handler }

  describe "#execute" do
    it "delegates to handler" do
      helper.execute Method, "private"
      expect(handler).to have_received(:call).with(Method, "private")
    end
  end
end
