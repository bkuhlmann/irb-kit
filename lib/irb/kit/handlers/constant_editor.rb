# frozen_string_literal: true

module IRB
  module Kit
    module Handlers
      # Handles editing of constant source code.
      class ConstantEditor < Abstract
        def initialize(editor: Editor.new, **)
          @editor = editor
          super(**)
        end

        def call name
          editor.call(*Object.const_source_location(name))
        rescue NameError
          io.puts "ERROR (invalid constant): #{name.inspect}."
        end

        private

        attr_reader :editor
      end
    end
  end
end
