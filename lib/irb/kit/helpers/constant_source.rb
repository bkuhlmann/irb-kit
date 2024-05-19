# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Finds constant's source location.
      class ConstantSource < IRB::HelperMethod::Base
        MONIKER = :csource

        description "Find a constant's source location."

        def initialize object = Object
          super()
          @object = object
        end

        def execute name
          object.const_source_location name
        rescue NameError
          "ERROR: Invalid constant (#{name.inspect})."
        end

        private

        attr_reader :object
      end
    end
  end
end
