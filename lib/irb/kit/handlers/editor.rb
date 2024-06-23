# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Handles editing of source code.
      class Editor < Abstract
        def initialize(environment: ENV, kernel: Kernel, **)
          @environment = environment
          @kernel = kernel
          super(**)
        end

        def call path, line = nil
          path_and_line = [path, line].join ":"

          if path && Pathname(path).exist?
            io.puts "Editing: #{path_and_line}..."
            kernel.system %(#{environment.fetch "EDITOR"} #{path_and_line})
          else
            io.puts "ERROR (invalid path): #{path}."
          end
        rescue KeyError then io.puts "ERROR: The `EDITOR` environment variable must be defined."
        end

        private

        attr_reader :environment, :kernel
      end
    end
  end
end
