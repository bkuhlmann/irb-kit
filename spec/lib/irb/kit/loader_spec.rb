# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Loader do
  subject(:loader) { described_class.new registrar, :Helpers }

  let(:registrar) { class_spy IRB::HelperMethod }

  describe "#call" do
    it "loads all helpers", :aggregate_failures do
      namespace = IRB::Kit::Helpers
      loader.call :all

      namespace.constants
               .sort
               .map { |name| namespace.const_get "#{namespace}::#{name}" }
               .each do |helper|
                 expect(registrar).to have_received(:register).with(helper::MONIKER, helper)
               end
    end

    it "loads no helpers when given no monikers" do
      loader.call
      expect(registrar).not_to have_received(:register)
    end

    it "loads specific helpers when given specific monikers" do
      loader.call :search
      expect(registrar).to have_received(:register).with(:search, IRB::Kit::Helpers::Search)
    end
  end
end
