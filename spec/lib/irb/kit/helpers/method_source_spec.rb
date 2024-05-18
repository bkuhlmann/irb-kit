# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::MethodSource do
  subject(:helper) { described_class.instance }

  describe "#execute" do
    it "answers source location" do
      expect(helper.execute(IRB, :start)).to match(
        array_including(
          %r(gems/irb-.*/lib/irb\.rb),
          kind_of(Integer)
        )
      )
    end

    it "answers name error for invalid method" do
      expect(helper.execute(IRB, :bogus)).to eq(
        "ERROR: undefined method `bogus' for class `#<Class:IRB>'"
      )
    end
  end
end
