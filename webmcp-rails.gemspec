# frozen_string_literal: true

require_relative "lib/webmcp/version"

Gem::Specification.new do |spec|
  spec.name = "webmcp-rails"
  spec.version = Webmcp::VERSION
  spec.authors = ["Jesse Waites"]
  spec.email = ["jesse@example.com"]

  spec.summary = "WebMCP attributes for Rails forms"
  spec.description = "Adds WebMCP (W3C) tool attributes to Rails form_with/form_for via a clean webmcp: option"
  spec.homepage = "https://github.com/jessewaites/webmcp-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
