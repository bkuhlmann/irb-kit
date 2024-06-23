# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Pastes last entry from macOS clipboard.
      class Paste < IRB::HelperMethod::Base
        MONIKER = :paste

        description "Paste last entry from macOS clipboard."

        def initialize handler: Handlers::Paster.new
          super()
          @handler = handler
        end

        def execute = handler.call

        private

        attr_reader :handler
      end
    end
  end
end
