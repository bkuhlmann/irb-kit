# frozen_string_literal: true

module IRB
  module Kit
    module Commands
      # Answers descendants of a class.
      class Descendants < IRB::Command::Base
        MONIKER = :descendants

        category "Kit"

        description "Show class descendants."

        help_message <<~BODY
          Usage: descendants <class>

          Examples:

            descendants Object
            descendants IO
            descendants Ractor::Error
        BODY

        def initialize context, handler: Handlers::Descender.new
          super context
          @handler = handler
        end

        def execute(name) = handler.call(name)

        private

        attr_reader :handler
      end
    end
  end
end
