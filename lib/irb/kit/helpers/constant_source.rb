# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Finds constant's source location.
      class ConstantSource < IRB::HelperMethod::Base
        MONIKER = :csource

        description "Find a constant's source location."

        def initialize object = Object, delimiter: ":"
          super()
          @object = object
          @delimiter = delimiter
        end

        def execute name
          object.const_source_location(name).then { |details| details.join delimiter if details }
        rescue NameError
          "ERROR: Invalid constant (#{name.inspect})."
        end

        private

        attr_reader :object, :delimiter
      end
    end
  end
end
