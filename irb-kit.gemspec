# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "irb-kit"
  spec.version = "0.9.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/irb-kit"
  spec.summary = "Extends IRB by providing additional productivity enhancements."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/irb-kit/issues",
    "changelog_uri" => "https://alchemists.io/projects/irb-kit/versions",
    "homepage_uri" => "https://alchemists.io/projects/irb-kit",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "IRB Kit",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/irb-kit"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "irb", "~> 1.14"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
