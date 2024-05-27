# frozen_string_literal: true

require "spec_helper"

RSpec.describe IRB::Kit::Prompter do
  subject(:prompter) { described_class.new }

  describe "#execute" do
    let :hanami_fake do
      Module.new do
        def self.app = :"Hanami_Test::App"

        def self.env = "development"
      end
    end

    let :rails_fake do
      Module.new do
        def self.application
          Module.new do
            def self.class
              Module.new { def self.module_parent_name = "rails_test" }
            end
          end
        end

        def self.env = "development"

        def self.version = "1.2.3"
      end
    end

    it "answers Ruby version and gem name" do
      expect(prompter.call).to match(/\d+\.\d+\.\d+\|(irb-kit|project)/)
    end

    it "answers prompt with custom delimiter" do
      prompter = described_class.new delimiter: "-"
      expect(prompter.call).to match(/\d+\.\d+\.\d+-(irb-kit|project)/)
    end

    it "answers Ruby version when Hanami version constant isn't found" do
      stub_const "Hanami", hanami_fake
      expect(prompter.call).to match(/\d+\.\d+\.\d+\|(irb-kit|project)/)
    end

    it "answers Ruby version, Hanami version, project name, and development environment" do
      stub_const "Hanami", hanami_fake
      stub_const "Hanami::VERSION", "1.1.1"

      expect(prompter.call).to eq("#{RUBY_VERSION}|1.1.1|hanami_test|\e[32mdevelopment\e[0m")
    end

    it "answers Ruby version, Hanami version, project name, and production environment" do
      allow(hanami_fake).to receive(:env).and_return "production"
      stub_const "Hanami", hanami_fake
      stub_const "Hanami::VERSION", "1.1.1"

      expect(prompter.call).to eq("#{RUBY_VERSION}|1.1.1|hanami_test|\e[31mproduction\e[0m")
    end

    it "answers Ruby version, Rails version, project name, and development environment" do
      stub_const "Rails", rails_fake
      expect(prompter.call).to eq("#{RUBY_VERSION}|1.2.3|rails_test|\e[32mdevelopment\e[0m")
    end

    it "answers Ruby version, Rails version, project name, and production environment" do
      allow(rails_fake).to receive(:env).and_return("production")
      stub_const "Rails", rails_fake

      expect(prompter.call).to eq("#{RUBY_VERSION}|1.2.3|rails_test|\e[31mproduction\e[0m")
    end
  end
end
