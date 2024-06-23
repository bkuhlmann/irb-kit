# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Handles searching an object's methods by pattern.
      class Searcher < Abstract
        def initialize(matcher: Regexp, **)
          @matcher = matcher
          super(**)
        end

        def call object, pattern
          object.methods
                .grep(matcher.new(pattern))
                .join("\n")
                .then { |result| result.empty? ? io.puts("No matches found.") : io.puts(result) }
        rescue TypeError
          io.puts "ERROR: Use only a string or regular expression for the pattern."
        end

        private

        attr_reader :matcher
      end
    end
  end
end
