# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Pastes last entry from macOS clipboard.
      class Paste < IRB::HelperMethod::Base
        MONIKER = :paste

        description "Paste last entry from macOS clipboard."

        def initialize io = IO
          super()
          @io = io
        end

        def execute
          io.popen "pbpaste", "r", &:read
        rescue Errno::ENOENT
          "ERROR: Unable to paste since `pbpaste` is only supported on macOS."
        end

        private

        attr_reader :io
      end
    end
  end
end
