# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Handles editing of method source code.
      class MethodEditor < Abstract
        def initialize(editor: Editor.new, **)
          @editor = editor
          super(**)
        end

        def call object, name
          editor.call(*object.method(name).source_location)
        rescue NameError
          io.puts "ERROR: Undefined method `#{name.inspect}` for `#{object.inspect}`."
        end

        private

        attr_reader :editor
      end
    end
  end
end
