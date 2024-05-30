# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Find an object method's source location.
      class MethodSource < IRB::HelperMethod::Base
        MONIKER = :msource

        description "Find an object method's source location."

        def initialize delimiter: ":"
          super()
          @delimiter = delimiter
        end

        def execute object, name
          object.method(name).source_location.then { |details| details.join delimiter if details }
        rescue NameError => error
          "ERROR: #{error.message}"
        end

        private

        attr_reader :delimiter
      end
    end
  end
end
