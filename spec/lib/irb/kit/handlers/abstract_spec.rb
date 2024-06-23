# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::Abstract do
  subject(:handler) { described_class.new }

  describe "#call" do
    it "fails when not implemented" do
      expectation = proc { handler.call }

      expect(&expectation).to raise_error(
        NoMethodError,
        "`#{described_class}#call []` must be implemented."
      )
    end
  end
end
