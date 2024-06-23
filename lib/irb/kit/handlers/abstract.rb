# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Provides default functionality for all handlers.
      class Abstract
        def initialize io: STDOUT
          @io = io
        end

        def call
          fail NoMethodError,
               "`#{self.class}##{__method__} #{method(__method__).parameters}` must be implemented."
        end

        protected

        attr_reader :io
      end
    end
  end
end
