# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Copies input to macOS clipboard.
      class Clip < IRB::HelperMethod::Base
        MONIKER = :clip

        description "Copy input to macOS clipboard."

        def initialize io = IO
          super()
          @io = io
        end

        def execute(*lines)
          io.popen("pbcopy", "w") { |clipboard| clipboard.write lines.join("\n") }
        rescue Errno::ENOENT
          "ERROR: Unable to copy since `pbcopy` is only supported on macOS."
        end

        private

        attr_reader :io
      end
    end
  end
end
