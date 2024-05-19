# frozen_string_literal: true

module IRB
  module Kit
    # Loads IRB extensions for namespace.
    class Loader
      ALL = [:all].freeze

      def initialize registrar, namespace, all: ALL
        @registrar = registrar
        @namespace = IRB::Kit.const_get namespace
        @all = all
      end

      def call(*monikers) = monikers == all ? register_all : register_selected(*monikers)

      private

      attr_reader :registrar, :namespace, :all

      def register_all = helpers.each { |helper| registrar.register helper::MONIKER, helper }

      def register_selected(*monikers)
        helpers.select { |helper| monikers.include? helper::MONIKER }
               .then { |selected| monikers.zip selected }
               .each { |moniker, helper| registrar.register moniker, helper }
      end

      def helpers = namespace.constants.sort.map { |name| namespace.const_get name }
    end
  end
end
