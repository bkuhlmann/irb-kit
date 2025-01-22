# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Copies input to macOS clipboard.
      class Clip < IRB::HelperMethod::Base
        MONIKER = :clip

        description "Copy input to macOS clipboard. DEPRECATED."

        def initialize handler: Handlers::Clipper.new
          super()
          @handler = handler
        end

        def execute(*)
          warn "`clip` is deprecated, use IRB's native `copy` helper instead.",
               category: :deprecated

          handler.call(*)
        end

        private

        attr_reader :handler
      end
    end
  end
end
