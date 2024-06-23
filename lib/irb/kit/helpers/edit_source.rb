# frozen_string_literal: true

require "pathname"

module IRB
  module Kit
    module Helpers
      # Edits the source code of a constant or method.
      class EditSource < IRB::HelperMethod::Base
        MONIKER = :esource

        description "Edit the source code of a constant or method in your default editor."

        def initialize constant_handler: Handlers::ConstantEditor.new,
                       method_handler: Handlers::MethodEditor.new
          super()
          @constant_handler = constant_handler
          @method_handler = method_handler
        end

        def execute(*arguments)
          case arguments
            in [name] then puts constant_handler.call(name)
            in [object, name] then puts method_handler.call(object, name)
            else puts "ERROR: Invalid constant or method for arguments: #{arguments.inspect}."
          end
        end

        private

        attr_reader :constant_handler, :method_handler
      end
    end
  end
end
