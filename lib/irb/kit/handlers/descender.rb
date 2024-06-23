# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Handles finding the descendants of a class.
      class Descender < Abstract
        def initialize(collector: ObjectSpace, **)
          @collector = collector
          super(**)
        end

        def call name
          collect(name).then { |all| all.empty? ? "No descendants found." : all.join("\n") }
                       .then { |result| io.puts result }
        rescue NameError
          io.puts "ERROR: #{name.inspect} doesn't exist."
        end

        private

        attr_reader :collector

        def collect name
          superclass = Object.const_get name

          collector.each_object(Class)
                   .select { |subclass| subclass < superclass }
                   .tap { |descendants| descendants.delete superclass }
                   .map(&:to_s)
                   .sort
        end
      end
    end
  end
end
