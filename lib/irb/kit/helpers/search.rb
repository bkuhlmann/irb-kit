# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Search an object's methods by pattern.
      class Search < IRB::HelperMethod::Base
        MONIKER = :search

        description "Search an object's methods by pattern."

        def initialize regex = Regexp
          super()
          @regex = regex
        end

        def execute object, pattern
          object.methods.grep regex.new(pattern)
        rescue TypeError
          "ERROR: Use only a string or regular expression for the pattern."
        end

        private

        attr_reader :regex
      end
    end
  end
end
