# frozen_string_literal: true

require "irb"
require "zeitwerk"

Zeitwerk::Loader.new.then do |loader|
  loader.inflector.inflect "irb" => "IRB"
  loader.tag = "irb-kit"
  loader.push_dir "#{__dir__}/.."
  loader.setup
end

module IRB
  # Main namespace.
  module Kit
    def self.loader registry = Zeitwerk::Registry
      @loader ||= registry.loaders.each.find { |loader| loader.tag == "irb-kit" }
    end

    def self.register_commands(*) = Register.new(IRB::Command, :Commands).call(*)

    def self.register_helpers(*) = Register.new(IRB::HelperMethod, :Helpers).call(*)

    def self.prompt = @prompt ||= Prompter.new.call
  end
end
