# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Handles copying content to the macOS clipboard.
      class Clipper < Abstract
        def initialize(processor: IO, **)
          @processor = processor
          super(**)
        end

        def call(*lines)
          processor.popen("pbcopy", "w") { |clipboard| clipboard.write lines.join("\n") }
          io.puts "Copied to clipboard."
        rescue Errno::ENOENT
          io.puts "ERROR: Unable to copy since `pbcopy` is only supported on macOS."
        end

        private

        attr_reader :processor
      end
    end
  end
end
