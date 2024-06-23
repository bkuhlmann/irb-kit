# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Handlers::Editor do
  subject(:handler) { described_class.new environment:, kernel:, io: }

  include_context "with temporary directory"

  let(:environment) { {"EDITOR" => "test_editor"} }
  let(:kernel) { class_spy Kernel }
  let(:io) { instance_spy IO }
  let(:path) { temp_dir.join "test.txt" }

  describe "#call" do
    it "edits file when path exists" do
      path.write "test"
      handler.call path, 123

      expect(kernel).to have_received(:system).with(/test_editor.+test.txt:123/)
    end

    it "prints information when path exists" do
      path.write "test"
      handler.call path, 123

      expect(io).to have_received(:puts).with("Editing: #{path}:123...")
    end

    it "prints environment error when EDITOR key is missing" do
      environment.delete "EDITOR"
      path.write "test"
      handler.call path

      expect(io).to have_received(:puts).with(
        "ERROR: The `EDITOR` environment variable must be defined."
      )
    end

    it "prints invalid path error when path doesn't exist" do
      handler.call path
      expect(io).to have_received(:puts).with("ERROR (invalid path): #{path}.")
    end
  end
end
