# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Pastes last entry from macOS clipboard.
      class Paste < IRB::HelperMethod::Base
        description "Paste last entry from macOS clipboard."

        def self.moniker = :paste

        # :nocov:
        def initialize io = IO
          super()
          @io = io
        end

        def execute = io.popen "pbpaste", "r", &:read

        private

        attr_reader :io
      end
    end
  end
end
