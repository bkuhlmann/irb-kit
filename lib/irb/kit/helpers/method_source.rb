# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Find an object method's source location.
      class MethodSource < IRB::HelperMethod::Base
        MONIKER = :msource

        description "Find an object method's source location."

        def execute object, name
          object.method(name).source_location
        rescue NameError => error
          "ERROR: #{error.message}"
        end
      end
    end
  end
end
