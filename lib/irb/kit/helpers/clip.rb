# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Copies input to macOS clipboard.
      class Clip < IRB::HelperMethod::Base
        MONIKER = :clip

        description "Copy input to macOS clipboard."

        def initialize handler: Handlers::Clipper.new
          super()
          @handler = handler
        end

        def execute(*) = handler.call(*)

        private

        attr_reader :handler
      end
    end
  end
end
