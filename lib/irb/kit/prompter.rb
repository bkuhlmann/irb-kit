# frozen_string_literal: true

module IRB
  module Kit
    # Dynamically computes prompt based environment.
    class Prompter
      COLORS = {green: 32, red: 31}.freeze

      def initialize version = RUBY_VERSION, delimiter: "|", colors: COLORS
        super()
        @version = version
        @delimiter = delimiter
        @colors = colors
      end

      def call
        if defined? Hanami::VERSION
          details Hanami::VERSION, Hanami.app.name.delete_suffix("::App"), Hanami.env
        elsif defined? Rails
          details Rails.version, Rails.application.class.module_parent_name, Rails.env
        else version_with_optional_project
        end
      end

      private

      attr_reader :version, :delimiter, :colors

      def details framework_version, application_name, environment
        [version, framework_version, application_name.downcase, color(environment)].join delimiter
      end

      def color environment
        code = environment.to_sym == :production ? red : green
        "\e[#{code}m#{environment}\e[0m"
      end

      def version_with_optional_project
        File.basename(`git rev-parse --show-toplevel 2> /dev/null`.strip)
            .downcase
            .then { |project| [version, project].reject(&:empty?).join delimiter }
      end

      def green = colors.fetch __method__

      def red = colors.fetch __method__
    end
  end
end
