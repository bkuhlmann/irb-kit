# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Helpers::EditSource do
  subject(:helper) { described_class.instance }

  let :constant_handler do
    instance_spy IRB::Kit::Handlers::ConstantEditor, call: "editing constant"
  end

  let :method_handler do
    instance_spy IRB::Kit::Handlers::MethodEditor, call: "editing method"
  end

  before do
    helper.instance_variable_set :@constant_handler, constant_handler
    helper.instance_variable_set :@method_handler, method_handler
  end

  describe "#execute" do
    it "delegates to constant handler" do
      helper.execute "IRB::IRBRC_EXT"
      expect(constant_handler).to have_received(:call).with "IRB::IRBRC_EXT"
    end

    it "prints constant being edited" do
      expectation = proc { helper.execute "IRB::IRBRC_EXT" }
      expect(&expectation).to output("editing constant\n").to_stdout
    end

    it "delegates to method handler" do
      helper.execute IRB, :start
      expect(method_handler).to have_received(:call).with IRB, :start
    end

    it "prints method being edited" do
      expectation = proc { helper.execute IRB, :start }
      expect(&expectation).to output("editing method\n").to_stdout
    end

    it "prints error with invalid arguments" do
      expectation = proc { helper.execute 1, 2, 3 }
      error = "ERROR: Invalid constant or method for arguments: [1, 2, 3].\n"

      expect(&expectation).to output(error).to_stdout
    end
  end
end
