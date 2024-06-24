# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Register do
  subject(:register) { described_class.new registrar, :Helpers }

  let(:registrar) { class_spy IRB::HelperMethod }

  describe "#call" do
    it "registers the maximum", :aggregate_failures do
      namespace = IRB::Kit::Helpers
      register.call :all

      namespace.constants
               .sort
               .map { |name| namespace.const_get "#{namespace}::#{name}" }
               .each do |helper|
                 expect(registrar).to have_received(:register).with(helper::MONIKER, helper)
               end
    end

    it "registers specific moniker" do
      register.call :search
      expect(registrar).to have_received(:register).with(:search, IRB::Kit::Helpers::Search)
    end

    it "registers nothing when given no monikers" do
      register.call
      expect(registrar).not_to have_received(:register)
    end
  end
end
