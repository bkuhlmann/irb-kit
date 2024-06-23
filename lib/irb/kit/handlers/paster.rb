# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Handles pasting content from the macOS clipboard.
      class Paster < Abstract
        def initialize(processor: IO, **)
          @processor = processor
          super(**)
        end

        def call
          processor.popen "pbpaste", "r", &:read
        rescue Errno::ENOENT
          io.puts "ERROR: Unable to paste since `pbpaste` is only supported on macOS."
        end

        private

        attr_reader :processor
      end
    end
  end
end
