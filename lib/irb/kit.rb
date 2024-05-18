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
      @loader ||= registry.loaders.find { |loader| loader.tag == "irb-kit" }
    end
  end
end
