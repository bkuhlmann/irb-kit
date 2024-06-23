# frozen_string_literal: true

module IRB
  module Kit
    module Helpers
      # Search an object's methods by pattern.
      class Search < IRB::HelperMethod::Base
        MONIKER = :search

        description "Search an object's methods by pattern."

        def initialize handler: Handlers::Searcher.new
          super()
          @handler = handler
        end

        def execute(*) = handler.call(*)

        private

        attr_reader :handler
      end
    end
  end
end
